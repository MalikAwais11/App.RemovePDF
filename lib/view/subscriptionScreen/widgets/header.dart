import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../generated/assets.dart';
import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/AdsManager.dart';


class proHeader extends StatefulWidget {
  const proHeader({super.key});

  @override
  State<proHeader> createState() => _proHeaderState();
}

class _proHeaderState extends State<proHeader> {

  final con = Get.put(AdsManager());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Obx(()=> Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: !con.isPro.value? [

            Image.asset( Assets.imagesCrown, height: 7.h),

            SizedBox(height: 1.h,),
            Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    style: TextStyle(color: AppColors.lightTextColor, fontSize: 19.sp, fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(text: "Get".tr+" "),
                      TextSpan(text: "Premium".tr, style: TextStyle(color: AppColors.themeColor, fontSize: 19.sp, fontWeight: FontWeight.w700)),

                    ]
                )
            ),
            SizedBox(height: 0.5.h,),
            Text("Claim the amazing features".tr, style: TextStyle(color: AppColors.lightTextColor, fontSize: 18.sp, fontWeight: FontWeight.w500),),


          ] : [
            Image.asset( Assets.imagesCrown, height: 7.h),
            SizedBox(height: 1.h,),
            Text("Congratulation".tr, style: TextStyle(color: AppColors.themeColor, fontSize: 20.sp, fontWeight: FontWeight.w700),),
            SizedBox(height: 0.5.h,),
            Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    style: TextStyle(color: AppColors.lightTextColor, fontSize: 19.sp, fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(text: "You are a".tr+" "),
                      TextSpan(text: "Premium User".tr, style: TextStyle(color: AppColors.themeColor, fontSize: 19.sp, fontWeight: FontWeight.w700)),

                    ]
                )
            ),

          ],
        )),



        // Obx(()=>  Image.asset(con.isPro.value? Assets.assetsCongratsHeader : Assets.assetsPremuimHeader, height: 10.h,)),


        SizedBox(height: 4.h,),


        Container(
          // color: Colors.red,
          width: Device.width,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text("✓  "+"Ad-Free Experience".tr, style: TextStyle(color: AppColors.themeColor, fontSize: 17.sp, fontWeight: FontWeight.w700),),
              SizedBox(height: 3.h,),
              Text("✓  "+"Exclusive Support".tr, style: TextStyle(color: AppColors.themeColor, fontSize: 17.sp, fontWeight: FontWeight.w700),),

            ],
          ),
        ),


        SizedBox(height: 4.h,),
      ],
    );
  }
}
