import 'package:deletepdfpage/viewModel/AdsManager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:pdfrx/pdfrx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io';
import '../../../res/appColors/appColors.dart';
import '../../../viewModel/themeController.dart';
import '../../components/bannerAd.dart';
import '../../components/themeButton.dart';
import '../../utils/appUtils.dart';
import '../mainScreen/mainScreen.dart';


class pdfViewer extends StatefulWidget {

  final filePath;
  final type;
  const pdfViewer({super.key, required this.filePath, required this.type});

  @override
  State<pdfViewer> createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {

  final pdfCon = PdfViewerController();

  final themeCon = Get.put(themeController());
  final Ads = Get.put(AdsManager());



  @override
  void initState() {
    Ads.showInterstitialAd();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){

        if(widget.type ==  "new"){
          Get.offAll(()=> mainScreen());
        }else{
          Get.back();
        }


        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppUtils.getFileName(File(widget.filePath))),
        ),
        body: Column(
          children: [
            bannerAd(),
            Expanded(
              child: PdfViewer.file(
                widget.filePath,
                controller: pdfCon,

                params: PdfViewerParams(
                  backgroundColor: themeCon.isLightTheme.value? AppColors.lightBgColor : AppColors.darkBgColor,
                  viewerOverlayBuilder:(context, size, p) => [

                    PdfViewerScrollThumb(
                      margin: 0,
                      controller: pdfCon,
                      orientation: ScrollbarOrientation.right,
                      thumbSize:  Size(20.w, 5.h),
                      thumbBuilder:
                          (context, thumbSize, pageNumber, controller) =>
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                // borderRadius: BorderRadius.circular(15.sp),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.sp),
                                  bottomLeft: Radius.circular(15.sp),
                                )
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              pageNumber.toString() +"/"+ pdfCon.pages.length.toString(),
                              style:  TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                    ),


                  ],


                  loadingBannerBuilder: (context, bytesDownloaded, totalBytes) => Center(
                    child:  CircularProgressIndicator(
                      backgroundColor: themeCon.isLightTheme.value? AppColors.lightBgColor : AppColors.darkBgColor,
                      color: AppColors.themeColor,
                    ),
                  ),



                ),





              ),
            ),
            SizedBox(height: 2.h),
            Padding(
              padding:  EdgeInsets.only(left: 2.w, right: 2.w),
              child: themButton(text: "Export PDF".tr,
                  bgColor: AppColors.themeColor,
                  textColor: AppColors.darkTextColor,
                  height: 6.h,
                  width:Device.width,

                  onTap:() async {


                    String? outputFilePath = await FilePicker.platform.saveFile(
                      dialogTitle: 'Please select an output file:',
                      bytes: await  File(widget.filePath).readAsBytesSync(),
                      fileName: '${AppUtils.getFileName(File(widget.filePath!))}',
                    );

                    if(outputFilePath != null){

                      if(Platform.isIOS){
                        Ads.showInterstitialAd();
                      }
                      AppUtils.showMsg("Success!".tr, "The PDF file has been successfully exported.".tr);

                    }

                  }

              ),
            ),
            SizedBox(height: 3.h),

          ],
        ),
      ),
    );
  }
}
