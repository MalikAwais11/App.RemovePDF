import 'dart:io';

import 'package:deletepdfpage/view/mainScreen/mainScreen.dart';
import 'package:deletepdfpage/view/previewScreens/pdfViewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../components/themeButton.dart';
import '../../../res/appStrings/appTools.dart';
import '../../../utils/appUtils.dart';

import 'package:pdfrx/pdfrx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';


import '../../../../../res/appColors/appColors.dart';
import '../../../../../viewModel/themeController.dart';
import '../../../viewModel/AdsManager.dart';
import '../../components/bannerAd.dart';
import '../historyScreen/historyScreen.dart';



class toolPagePreviewScreen extends StatefulWidget {
  File file;
  final type;



  final beforeCompressSize;

  toolPagePreviewScreen({super.key,  required this.file, required this.type, this.beforeCompressSize,});

  @override
  State<toolPagePreviewScreen> createState() => _toolPagePreviewScreenState();
}

class _toolPagePreviewScreenState extends State<toolPagePreviewScreen> {


  final Ads = Get.put(AdsManager());



  @override
  void initState() {
    Ads.showInterstitialAd();
    super.initState();
  }


  final themeCon = Get.put(themeController());

  // final con = Get.put(splitPDFController());


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // canPop: true,
      onWillPop: (){

        Get.off(()=> mainScreen());

        return Future.value(true);
      },

      child: Scaffold(
        appBar: AppBar(title: Text("Preview".tr),),
        body: Column(
          children: [
            // bannerAd(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    SizedBox(height: 0.h,),

                    Container(

                      width: Device.width/1.5,
                      // color: Colors.red,

                        height: Device.height/2.4,

                      child:  PdfDocumentViewBuilder.file(
                          widget.file.path,
                          builder: (context, document) => Container(

                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.sp),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    child: PdfPageView(
                                    decoration: BoxDecoration(

                                        borderRadius: BorderRadius.circular(20.sp)
                                    ),

                                    document: document,
                                    // pdfDocument: pdfDocument,
                                    pageNumber: 1,
                                  ),
                                ),
                              )
                          )
                      )
                    ),

                    SizedBox(height: 2.h,),

                    Padding(
                      padding:  EdgeInsets.only(left: 14.sp, right: 14.sp),
                      child: Obx(() => Text(
                        AppUtils.getFileName(widget.file),
                        // maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color:themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700
                        ),
                      )),
                    ),

                    SizedBox(height: 1.h,),

                    Text("File Size: ${AppUtils.convertFileSize(bytes: widget.file.lengthSync())} ",

                      style: TextStyle(
                          color:themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor,
                          fontSize: 16.5.sp,
                          fontWeight: FontWeight.w700
                      ),
                    ),


                    SizedBox(height: 4.h,),


                    Row(
                      children: [


                        SizedBox(width: 4.w),
                        Expanded(
                          child: Card(
                            elevation: 1,
                            child: themButton(text: "Share".tr,
                              bgColor: (themeCon.isLightTheme.value? AppColors.lightCardColor : AppColors.darkCardColor),
                              textColor: (themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor),
                              height: 6.h,
                              width:0.w,
                              onTap: () {



                                Share.shareXFiles([XFile(widget.file.path)]);



                              } ,

                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),


                        Expanded(

                          child: themButton(text: "View PDF".tr,
                              bgColor: AppColors.themeColor,
                              textColor: AppColors.darkTextColor,
                              height: 6.h,
                              width:0.w,

                              onTap:(){



                            Get.to(()=> pdfViewer(filePath: widget.file.path, type: widget.type,));

                                // Get.to(()=> PdfPreviewScreen(filePath: widget.file.path));




                                // AppUtils.sendAnalyticsEvent(eventName: "ViewPDF_${widget.type.toString().replaceAll(" ", "")}_FromPreviewScreen", clickedEvent:"user clicked ViewPDF button to View PDF from Preview Screen");



                              }

                          ),
                        ) ,


                        SizedBox(width: 4.w),


                      ],
                    )



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}
