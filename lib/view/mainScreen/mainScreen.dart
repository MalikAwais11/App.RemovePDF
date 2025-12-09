import 'package:deletepdfpage/components/bannerAd.dart';
import 'package:deletepdfpage/view/historyScreen/historyScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:upgrader/upgrader.dart';


import '../../../res/appColors/appColors.dart';
import '../../../res/appStrings/appTools.dart';
import '../../../utils/appUtils.dart';
import '../../../viewModel/mainScreenController.dart';
import '../../../viewModel/themeController.dart';
import '../../components/settingSheet.dart';
import '../../components/themeButton.dart';
import '../../generated/assets.dart';


class mainScreen extends StatefulWidget {

  mainScreen({Key? key, }) : super(key: key);

  @override
  State<mainScreen> createState() => _mainScreenState();
}


class _mainScreenState extends State<mainScreen> {


  final con = Get.put(mainScreenController());


  final themeCon = Get.put(themeController());


  @override
  void initState() {
    AppUtils.setReviewTimes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(centerTitle: false, title: Text("PDF Page Remover".tr),
        actions: [



          SizedBox(width: 3.w,),



          Container(
            // color: Colors.red,
            child: InkWell(

              onTap: (){
                Get.to(()=> settingSheet());
              },

              child: Obx(()=>ImageIcon(AssetImage(Assets.imagesSetting,), color:   themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor, size: 22.sp,),),


            ),
          ),

          SizedBox(width: 3.w,),


        ],



      ),


      body: UpgradeAlert(
        upgrader: Upgrader(),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: Padding(
              padding: EdgeInsets.only(left:13.sp, right: 13.sp, bottom: 13.sp),
              child: Column(
                children: [
                  bannerAd(),
                  SizedBox(height: 1.h,),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          InkWell(
                            onTap: ()=> con.checkPermission(AppTools.deletePages, context),
                            child: Card(
                              margin: EdgeInsets.zero,
                              child: Container(
                                height: 13.h,
                                width: Device.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                    // gradient: LinearGradient(
                                    //     begin: Alignment.topLeft,
                                    //     end: Alignment.bottomRight,
                                    //
                                    //     colors: [
                                    //       Color(0xffDB0000),
                                    //       Color(0xffDB0000),
                                    //       // Color(0xff750000),
                                    //       // Color(0xff750000),
                                    //     ]
                                    //
                                    // ),
                                  borderRadius: BorderRadius.circular(16.sp),
                                  // border: Border.all(width: 5.5.sp, color: AppColors.themeColor),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ImageIcon(AssetImage(Assets.imagesUpload),color: Colors.white, size: 25.sp,),
                                    SizedBox(height: 1.h,),
                                    Text("Choose PDF", style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800),)
                                  ],
                                ),

                              ),
                            ),
                          ),


                          SizedBox(height: 2.h,),

                          Expanded(child: historyScreen()),


                          SizedBox(height: 2.h,),


                        ]
                    ),
                  ),
                ],
              )
          ),
        ),
      ),

    );
  }
}
