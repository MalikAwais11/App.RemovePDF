import 'dart:io';
import 'dart:math';

import 'package:deletepdfpage/view/previewScreens/pdfViewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/appColors/appColors.dart';
import '../res/appStrings/appTools.dart';
import '../res/appUrls/appUrls.dart';
import '../source/local/DataBase_Helper.dart';
import '../view/previewScreens/toolPagePreviewScreen.dart';


class AppUtils{



  static String getFileName(file){


    return file.path.toString().substring(file.path.toString().lastIndexOf("/")+1);

  }

  static showMsg(String title, String msg){


    Get.snackbar(
      title.tr,
      msg.tr,
      // msg,

      messageText : Text(msg.tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
      colorText: Colors.white,
      backgroundColor: AppColors.themeColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),


    );



  }


  static RateUs() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }

  }




  static setReviewTimes() async {
    final pref = await SharedPreferences.getInstance();
    int times = await pref.getInt("ReviewTime") ?? 0;
    pref.setInt("ReviewTime", times+1);
    print("ReviewTime: ${times+1}");
    if(await pref.getInt("ReviewTime")! % 4 == 0){
      RateUs();
      print("Time to Show Review Popup");
    }

  }



  static renameFile( name, filepath, toolName,  context, isLight, [beforeCompressedSized]){

    final rename = TextEditingController();


    rename.text = name.toString();
    // rename.text = name.toString().replaceAll(".pdf", "");



    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(
          maxWidth: Device.width,
        ),
        context: context, builder: (context){
      return Padding(
        padding:  MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30.h,
              // height: Device.height,
              width: Device.width,

              padding:  EdgeInsets.only(left: 14.sp, right: 14.sp,),
              decoration: BoxDecoration(
                color: isLight? AppColors.lightBgColor : AppColors.darkCardColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.sp),
                    topRight: Radius.circular(15.sp),
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(height: 2.h,),
                  Text("Rename File".tr, style: TextStyle(color: isLight? AppColors.lightTextColor : AppColors.darkTextColor, fontSize: 20.sp ,fontWeight: FontWeight.w800),),
                  SizedBox(height: 4.h,),

                  Container(
                    decoration: BoxDecoration(
                      color: isLight? AppColors.lightCardColor : AppColors.darkBgColor,
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 4.w,),
                        Expanded(
                          child: Container(
                            height: 7.h,
                            decoration: BoxDecoration(
                              color: isLight?  AppColors.lightCardColor : AppColors.darkCardColor,
                              borderRadius: BorderRadius.circular(15.sp),
                            ),
                            alignment: Alignment.center,
                            child: TextField(
                                controller: rename,
                                autofocus:true,

                                cursorColor: isLight? AppColors.lightTextColor : AppColors.darkTextColor,
                                style: TextStyle(
                                    fontSize:16.5.sp,
                                    color: isLight? AppColors.lightTextColor : AppColors.darkTextColor,
                                    fontWeight: FontWeight.w700),
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp('[/]+')),
                                ],



                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  fillColor: Colors.transparent,

                                  filled: true,

                                  border: InputBorder.none,
                                  hintText: 'Enter file name'.tr,
                                  hintStyle: TextStyle(color: isLight? AppColors.lightTextColor : AppColors.darkTextColor,),

                                  // focusedBorder: OutlineInputBorder(
                                  //   borderSide:  BorderSide(
                                  //     color: isLight? AppColors.lightCardColor : AppColors.darkCardColor,
                                  //   ),
                                  // ),
                                  // enabledBorder: OutlineInputBorder(
                                  //   borderSide:  BorderSide(
                                  //     color: isLight? AppColors.lightCardColor : AppColors.darkCardColor,
                                  //   ),
                                  // ),

                                )
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: ()=> rename.clear(),
                            child: Icon(Icons.close, size: 19.sp, color: isLight? AppColors.lightTextColor : AppColors.darkTextColor,)
                        ),

                        SizedBox(width: 3.w,),


                      ],
                    ),
                  ),
                  SizedBox(height: 2.h,),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap:(){
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                // border: Border.all(color: AppColors.textColor),
                                color: isLight? AppColors.lightCardColor :  AppColors.darkBgColor,

                                borderRadius: BorderRadius.circular(15.sp),

                              ),
                              height: 6.h,
                              child: Center(
                                child:
                                Text("Cancel".tr,
                                  style: TextStyle(color: isLight? AppColors.lightTextColor : AppColors.darkTextColor, fontSize: 18.sp, fontWeight: FontWeight.w700),
                                ),

                              ),
                            )
                        ),
                      ),
                      SizedBox(width: 3.w,),
                      Expanded(
                        child: InkWell(
                            onTap: (){

                              if(rename.text == ""){

                                createFile( "${name}.pdf", filepath, toolName, beforeCompressedSized);

                              }else{

                                createFile( "${rename.text}.pdf", filepath, toolName, beforeCompressedSized);
                                Get.back();


                              }



                            },
                            child: Container(
                              decoration: BoxDecoration(

                                color: AppColors.themeColor,
                                borderRadius: BorderRadius.circular(15.sp),

                              ),
                              height: 6.h,
                              child: Center(child: Text("Done".tr, style: TextStyle(color:  Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),),

                              ),
                            )
                        ),
                      ),




                    ],
                  ),

                  SizedBox(height: 4.h,),


                ],
              ),
            ),
          ],
        ),
      );
    });





  }


  static createFile(name, filepath, toolName, [beforeCompressedSized]) async {


    print("CreateFile");

    try{

      String basePAth = (await getApplicationDocumentsDirectory()).path;


      print(filepath);


      var f = await File("${basePAth}/${name}").create();


      if(filepath!=null){

        f.writeAsBytesSync(await File(filepath!).readAsBytesSync());

      }



      print(f.path);


      Get.to(pdfViewer(filePath: f.path, type: "new"));

      // Get.off(()=> toolPagePreviewScreen(file: f, type: toolName, beforeCompressSize: beforeCompressedSized));


      await SQLHelper.createItem(
          toolName ,
          DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
          f.path,
        AppUtils.convertFileSize(bytes: f.lengthSync()),
        toolName == AppTools.compressPDF? beforeCompressedSized : "",
      ).then((value) => print("item Added"));


    }catch(e){

      print(e);

    }







  }






  static Future<bool> duplicateFileCheck(path) async {


    bool f = await File(path).exists();

    return f;
  }


  static disableKeyBoard(context){

    final FocusScopeNode currentScope = FocusScope.of(context);

    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }


  }


  static String convertFileSize({required int bytes, int decimals = 0}) {
    const suffixes = [" B", " KB", " MB", " GB", " TB"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }



  // static Future<int> getPDFPageCount(filePath)async {
  //
  //   PdfDocument doc = await PdfDocument.openFile(filePath);
  //
  //   return doc.pageCount;
  //
  // }



  static Future<int> getPDFPageCount(String filePath) async {
    try {

      final int totalPages = await MethodChannel('pdf_utils').invokeMethod('getTotalPages', {
        'filePath': filePath,
      });
      return totalPages;
    } on PlatformException catch (e) {
      print("Failed to get total pages: ${e.message}");
      return 0;
    }
  }





  static RateUsToStore() => launchUrl(Uri.parse(AppUrls.AndroidAppUrl), mode: LaunchMode.externalApplication);

  static ShareApp() => Share.share( AppUrls.AndroidAppUrl);

  static OtherApps() => launchUrl(Uri.parse(Platform.isIOS? AppUrls.ioStoreUrl : AppUrls.storeUrl), mode: LaunchMode.externalApplication);
  static ShareApps() => Share.share(AppUrls.AndroidAppUrl);
  static privacyPolicy()=> launchUrl(Uri.parse( AppUrls.policyUrl), mode: LaunchMode.externalApplication);
  static termsOfUse()=> launchUrl(Uri.parse(AppUrls.termsOfUSe), mode: LaunchMode.externalApplication);


  static sendMailFeedback() async {




    String email = Uri.encodeComponent("codifycontact10@gmail.com");
    String subject = Uri.encodeComponent("PDF Page Remover ${Platform.isIOS? "IOS" : "Android"}");
    String body = Uri.encodeComponent("");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {





    }else{

      //email app is not opened

    }


  }



  static Future sendAnalyticsEvent({required String eventName, required String clickedEvent}) async {
    // final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
    // await _analytics.logEvent(
    //   name: '${eventName}',
    //   parameters: <String, dynamic>{"value": clickedEvent},
    // );
    // debugPrint("Events Posted");
  }







  static List<Map> lang = [


    {'name': 'English', 'code': 'en'},
    {'name': 'Français', 'code': 'fr'},
    {'name': 'Español', 'code': 'es'},
    {'name': 'Deutsch', 'code': 'de'},
    {'name': 'Indonesia', 'code': 'id'},
    {'name': 'Italiano', 'code': 'it'},
    {'name': 'Português', 'code': 'pt'},
    {'name': 'Türkçe', 'code': 'tr'},
    {'name': 'Русский', 'code': 'ru'},
    {'name': 'العربية', 'code': 'ar'},
    {'name': 'Melayu', 'code': 'ms'},
    {'name': 'Polski', 'code': 'pl'},
    {'name': '日本語', 'code': 'ja'},
    {'name': '中文', 'code': 'zh-cn'},



  ];





}