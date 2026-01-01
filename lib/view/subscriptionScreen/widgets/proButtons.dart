import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deletepdfpage/components/themeButton.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:deletepdfpage/utils/appUtils.dart';

import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/AdsManager.dart';



class proButtons extends StatefulWidget {
  const proButtons({super.key});

  @override
  State<proButtons> createState() => _proButtonsState();
}

class _proButtonsState extends State<proButtons> {

  final con = Get.put(AdsManager());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        SizedBox(height: 4.h,),
        
        

        Obx(()=> themButton(
          textColor: AppColors.darkTextColor,
          height: 6.h,
          bgColor: AppColors.themeColor,
          text: con.isPro.value? "Manage Subscription".tr : "Subscribe".tr,
          width: Device.width,
          onTap:() =>  con.isPro.value? AppUtils.manageSubscription() :  con.purchasePlan(con.plansList[con.selectedPackage.value]),
        ),),
        

        SizedBox(height: 1.5.h,),


        Obx(()=> con.isPro.value? SizedBox() : InkWell(
            onTap: ()=> con.restorePurchases(),
            child: Text("Restore".tr, style: TextStyle(color: AppColors.subTitleColor, fontSize: 16.sp, fontWeight: FontWeight.w700),)) ),



        SizedBox(height: 3.5.h,),
      ],
    );
  }
}
