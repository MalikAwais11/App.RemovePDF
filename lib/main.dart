import 'package:deletepdfpage/components/bannerAd.dart';
import 'package:deletepdfpage/utils/appUtils.dart';
import 'package:deletepdfpage/utils/themeUtils.dart';
import 'package:deletepdfpage/view/splashScreen/splashScreen.dart';
import 'package:deletepdfpage/viewModel/AdsManager.dart';
import 'package:deletepdfpage/viewModel/themeController.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'package:responsive_sizer/responsive_sizer.dart';





void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);


  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  

  runApp(const MyApp());

}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {


  final themeCon = Get.put(themeController());
  final Ads = Get.put(AdsManager());



  @override
  void initState() {

    themeCon.getThemeStatus();

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      Ads.isActivityPaused.value = true;
    }
    if (state == AppLifecycleState.resumed && Ads.isActivityPaused.value) {
      print("Resumed");
      Ads.showInterstitialAd();
      Ads.isActivityPaused.value = false;
    }




  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {

          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              // translations: LocalStrings(),
              // locale: Locale(themeCon.selectedLang.value["code"]),

              theme: themeUtils.lightTheme,
              darkTheme: themeUtils.darkTheme,
              home: Splash_Screen()
          );
        }

    );

  }
}


