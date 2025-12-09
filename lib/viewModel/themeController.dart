import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

import '../res/appStrings/appStrings.dart';
import '../utils/appUtils.dart';

class themeController extends GetxController{


  var selectedLang = AppUtils.lang[0].obs;



  getLanguageCode(){

    ui.Locale currentLocale = ui.window.locale;

    String languageCode = currentLocale.languageCode;




    for(var lang in AppUtils.lang){

      if(lang["code"] == languageCode){


        selectedLang.value = lang;

        Get.updateLocale(Locale(selectedLang['code']));

        print("apply ${selectedLang['code']}");




        // AppUtils.sendAnalyticsEvent(eventName: "${lang["name"]}_Default_OpenApp", clickedEvent: "user Default Device Language");



      }


    }



  }


  RxBool themSwitch = false.obs;

  RxBool isLightTheme = false.obs;
  RxBool isFirstSession = true.obs;
  RxString selectedTheme = AppStrings.lightMode.obs;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // final Ads = Get.put(AdsManager());

  saveThemeStatus(status) async {
    SharedPreferences pref = await _prefs;
    pref.setString('theme', status);
    print("theme");
    print(pref.getString('theme'));
  }

  getThemeStatus() async {
    // if(Ads.isSubscribed.value) {
    //   SharedPreferences pref = await _prefs;
    //   print("from DB");
    //   print(pref.getString('theme'));
    //
    //   selectedTheme.value = (pref.getString('theme') != null ? pref.getString('theme') : AppStrings.lightMode)!;
    //
    //   // pref.setString("theme", selectedTheme.value);
    //
    //   if (selectedTheme.value == AppStrings.lightMode) {
    Get.changeThemeMode(ThemeMode.light);
    selectedTheme.value = AppStrings.lightMode;
    isLightTheme.value = true;



    // themSwitch.value = false;
    // }
    // else if (selectedTheme.value == AppStrings.darkMode) {
    //   Get.changeThemeMode(ThemeMode.dark);
    //   selectedTheme.value = AppStrings.darkMode;
    //   isLightTheme.value = false;
    //   themSwitch.value = true;
    // }

    // else if (selectedTheme.value == AppStrings.systemDefaultMode) {
    //   Get.changeThemeMode(ThemeMode.system);
    //
    //
    //   final brightness = MediaQuery
    //       .of(context)
    //       .platformBrightness;
    //   if (brightness == Brightness.light) {
    //     isLightTheme.value = true;
    //   }
    //   else {
    //     isLightTheme.value = false;
    //   }
    // }

    // saveThemeStatus(selectedTheme.value);
    // print(selectedTheme.value);

    // }
    // else{
    //   print("No User");
    //   Get.changeThemeMode(ThemeMode.light);
    //   isLightTheme.value = true;
    //   themSwitch.value = false;
    // }


  }

  setSession() async {
    SharedPreferences pref = await _prefs;
    pref.setBool("isFirst", true);
  }



  changeTheme(val){


    if(val == Brightness.dark){
      Get.changeThemeMode(ThemeMode.dark);
      selectedTheme.value = AppStrings.darkMode;
      isLightTheme.value = false;
    }
    else{
      Get.changeThemeMode(ThemeMode.light);
      selectedTheme.value = AppStrings.lightMode;
      isLightTheme.value = true;
    }
  }



}
