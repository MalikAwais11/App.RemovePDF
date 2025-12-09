import 'dart:io';
import 'package:deletepdfpage/res/appIds/AppIds.dart';
import 'package:deletepdfpage/res/appUrls/appUrls.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../Utils/appUtils.dart';
import '../data/network/networkApiServices.dart';
import '../model/dbLink.dart';


class AdsManager extends GetxController{

  final _api = NetworkApiServices();

  RxBool isAdsBlocked = false.obs;

  var isActivityPaused = false.obs;


  final interstitialAd = Rxn<InterstitialAd>();
  var numInterstitialLoadAttempts = 0.obs;
  var maxFailedLoadAttempts = 1.obs;


  @override
  void onInit() {

    AppUtils.setReviewTimes();

    checkDbLink();

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

  }



  void showInterstitialAd() {


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



  }


}
