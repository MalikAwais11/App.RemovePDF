import 'dart:io';
import 'package:deletepdfpage/res/appIds/AppIds.dart';
import 'package:deletepdfpage/res/appUrls/appUrls.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../Utils/appUtils.dart';
import '../data/network/networkApiServices.dart';
import '../model/dbLink.dart';
import '../res/appStrings/appStrings.dart';


class AdsManager extends GetxController{

  final _api = NetworkApiServices();

  RxBool isAdsBlocked = false.obs;

  var isActivityPaused = false.obs;


  final interstitialAd = Rxn<InterstitialAd>();
  var numInterstitialLoadAttempts = 0.obs;
  var maxFailedLoadAttempts = 1.obs;


  @override
  void onInit() {

    initRevenueCat();
    checkDbLink();
    AppUtils.setReviewTimes();


    super.onInit();
  }


  void checkDbLink() {
    _api.getApi(AppUrls.dBPenalUrl).then((value) {
      DbModel model = DbModel();
      model = DbModel.fromJson(value);

      DbLink dB = DbLink();

      if (model.success!) {
        for (var i in model.result!) {
          if (i.appName == AppUrls.dbName) {
            print(i.appName);
            dB = DbLink.fromJson(i.toJson());
          }
        }

        print(dB.v6);

        if (dB.v6 == AppUrls.dBOn) {
          isAdsBlocked.value = true;
          print("Ads Blocked by Admin");
        }

        createInterstitialAd();
      }
    }).onError((error, stackTrace) {
      print(stackTrace);
      print(error);
      createInterstitialAd();
    });
  }




  void createInterstitialAd() {
    if (!isPro.value) {
      if(!isAdsBlocked.value){
        InterstitialAd.load(
            adUnitId: Platform.isIOS? AppIds.iosInterstitialAdID : AppIds.interstitialAdID,
            request: AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
              onAdLoaded: (InterstitialAd ad) {
                interstitialAd.value = ad;
                numInterstitialLoadAttempts.value = 0;
                interstitialAd.value!.setImmersiveMode(true);
              },
              onAdFailedToLoad: (LoadAdError error) {
                print('InterstitialAd failed to load: $error.');
                numInterstitialLoadAttempts.value += 1;
                interstitialAd.value = null;
                if (numInterstitialLoadAttempts.value < maxFailedLoadAttempts.value) {
                  createInterstitialAd();
                }
              },
            ));
      }else{
        print("InterstitialAd Blocked by Admin");

      }
    }else{

      print("Pro version");

    }

  }


  void showInterstitialAd() {

    if(!isPro.value){

      if(!isAdsBlocked.value){

        if (interstitialAd.value == null) {
          print('Warning: attempt to show interstitial before loaded.');
          createInterstitialAd();
          return;
        }
        interstitialAd.value!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) =>
              print('ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            print('$ad onAdDismissedFullScreenContent.');
            ad.dispose();
            createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            createInterstitialAd();
          },
        );
        interstitialAd.value!.show();
        interstitialAd.value = null;
      }
      else{
        print("InterstitialAd Blocked by Admin");
      }
    }else{

      print("Pro version");

    }



  }



  RxList<Package> plansList = <Package>[].obs;
  RxInt selectedPackage = 0.obs;

  RxBool isLoading = false.obs;


  RxBool isPro = false.obs;
  RxString userId = "".obs;
  var plan = "".obs;
  var purchaseDate = "".obs;
  var expiryDate = "".obs;



  initRevenueCat() async {

    PurchasesConfiguration configuration = PurchasesConfiguration(Platform.isIOS? AppIds.revenueCatIOSId : AppIds.revenueCatAndroidId);
    await Purchases.configure(configuration);

    getCustomerInfo();


  }

  getCustomerInfo() async {

    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      print(customerInfo);

      if (customerInfo.entitlements.all.isNotEmpty) {

        print("dataaaa");
        print(customerInfo.entitlements.all);

        if(customerInfo.entitlements.all[AppIds.entitlementID]!.isActive){
          print("pro user");

          // getPlanInfo(customerInfo);
          isPro.value =  customerInfo.entitlements.active[AppIds.entitlementID]!.isActive;
          userId.value =  customerInfo.originalAppUserId;

        }else{

          print("free user");
          getOffers();
          isPro.value = false;

        }

      }else{
        print("free user");
        getOffers();
        isPro.value = false;
      }


    } on PlatformException catch (e) {
      print(e);
      isPro.value = false;
      getOffers();
    }

  }

  getOffers() async {

    print("called get Offers");

    try {

      Offerings offerings = await Purchases.getOfferings();

      print(offerings.current!.availablePackages);
      if (offerings.current != null && offerings.current!.availablePackages.isNotEmpty) {

        plansList.value = offerings.current!.availablePackages;

        plansList.refresh();
        print("plans");
        print(plansList.length);

        // print(plansList);

      }
    } on PlatformException catch (e) {
      // optional error handling
      print(e);
    }


  }


  purchasePlan(Package package) async {

    try{

      isLoading.value = true;

      PurchaseResult purchaserInfo = await Purchases.purchasePackage(package);

      bool pro = purchaserInfo.customerInfo.entitlements.all[AppIds.entitlementID]?.isActive ?? false;

      if (pro) {

        getPlanInfo(purchaserInfo);
        isLoading.value = false;

      }


    } on PlatformException catch (e) {


      isLoading.value = false;

      if (e.code == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled the purchase.");
      } else {
        print("Purchase error: ${e.message}");
      }


      print(e);
    }

  }


  getPlanInfo(PurchaseResult pInfo){


    isPro.value =  pInfo.customerInfo.entitlements.active[AppIds.entitlementID]!.isActive;
    userId.value =  pInfo.customerInfo.originalAppUserId;


  }


  void restorePurchases() async {
    try {
      isLoading.value = true;
      CustomerInfo purchaserInfo = await Purchases.restorePurchases();

      bool pro = purchaserInfo.entitlements.all[AppIds.entitlementID]?.isActive ?? false;
      if (pro) {
        isPro.value = true;
        isLoading.value = false;
      } else {
        isPro.value = false;
        isLoading.value = false;
        print("No active subscription.");
      }
    } on PlatformException catch (e) {
      isPro.value = false;
      isLoading.value = false;
      print("Error restoring purchases: ${e.message}");
    }
  }





}
