

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/mainScreenController.dart';
import '../../../../viewModel/themeController.dart';





class permissionSheet extends StatefulWidget {
  final toolId;
  final isDenied;
  const permissionSheet({Key? key, required this.toolId, required this.isDenied}) : super(key: key);

  @override
  State<permissionSheet> createState() => _permissionSheetState();
}

class _permissionSheetState extends State<permissionSheet> {

  final themeCon = Get.put(themeController());
  final con = Get.put(mainScreenController());


  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      height: Device.height / 2.5,
      width: Device.width,
      decoration: BoxDecoration(
          color: themeCon.isLightTheme.value? AppColors.lightBgColor : AppColors.darkBgColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.sp),
              topRight: Radius.circular(18.sp)
          )
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 20.sp, right: 20.sp),
        child: Column(

          children: [

            SizedBox(height: 4.h,),

            // Image.asset(Assets.imagesPermissionImage, width: Device.width/2.6,),

            SizedBox(height: 2.h,),


            Obx(() =>  Text("Allow access to view files".tr, style: TextStyle(color:themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor, fontSize: 20.sp,fontWeight: FontWeight.w700,),),),



            SizedBox(height: 1.h,),




            Obx(() => Text("We require access to your files to display PDFs. Rest assured, we don't collect or transfer any of your personal information.".tr,
              textAlign: TextAlign.center,
              style: TextStyle(color:themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor, fontSize: 16.sp,fontWeight: FontWeight.w600,),
            )),



            SizedBox(height: 5.h,),


            InkWell(
              onTap: (){
                if(widget.isDenied){
                  Get.back();
                  con.checkPermission(widget.toolId, context);

                }else{
                  Get.back();
                  openAppSettings();
                }
              },
              child: Container(
                height: 7.h,
                width: Device.width/2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(20.sp)
                ),
                child: Text("Allow Access".tr, style: TextStyle(color: AppColors.darkTextColor, fontSize: 18.sp, fontWeight: FontWeight.w700),),

              ),
            ),




          ],
        ),
      ),
    ));
  }
}
