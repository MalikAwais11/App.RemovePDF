import 'dart:io';
import 'package:deletepdfpage/res/appIds/AppIds.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../viewModel/AdsManager.dart';


class bannerAd extends StatefulWidget {
  const bannerAd({super.key});

  @override
  State<bannerAd> createState() => _bannerAdState();
}

class _bannerAdState extends State<bannerAd> {

  final con = Get.put(AdsManager());

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  void loadAd() async  {

    _bannerAd = BannerAd(

      adUnitId: Platform.isIOS? AppIds.bannerID : AppIds.iosBannerID,
      request: const AdRequest(),
      size: AdSize.fullBanner,

      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    con.isAdsBlocked.value? null : loadAd();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return  Obx(()=>   con.isAdsBlocked.value? SizedBox() : Align(
        alignment: Alignment.bottomCenter,
        child: _isLoaded? SizedBox(
          width: _bannerAd!.size.width.toDouble(),
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        ) : SizedBox()
    ));


  }
}
