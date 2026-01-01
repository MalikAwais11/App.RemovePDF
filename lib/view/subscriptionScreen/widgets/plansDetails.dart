import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:deletepdfpage/utils/appUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/assets.dart';
import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/AdsManager.dart';



class plansDetails extends StatefulWidget {
  const plansDetails({super.key});

  @override
  State<plansDetails> createState() => _plansDetailsState();
}



class _plansDetailsState extends State<plansDetails> {

  final con = Get.put(AdsManager());


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        InkWell(
          onTap: () async {


            String email = Uri.encodeComponent("codifycontact10@gmail.com");
            String subject = Uri.encodeComponent("Cove Page ${Platform.isIOS? "IOS" : "Android"} Subscription");
            String body = Uri.encodeComponent("Purchase ID:\n${con.userId.value}\n");
            Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
            if (await launchUrl(mail)) {





            }else{

              //email app is not opened

            }



          },
          child: Container(
            height: 10.h,
            width: Device.width,

            padding: EdgeInsets.only(left: 5.w),
            decoration: BoxDecoration(
                color: AppColors.lightCardColor,
                borderRadius: BorderRadius.circular(15.sp)
            ),
            child: Row(
              children: [
                Image.asset(Assets.imagesSupport, width: 9.w,),
                SizedBox(width: 4.w,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Help Support".tr,style: TextStyle(color: AppColors.lightTextColor, fontSize:18.sp, fontWeight: FontWeight.w700,),),
                      SizedBox(height: 0.5.h,),
                      Text("Need Help or Feedback? We’re Listening!".tr,style: TextStyle(color: AppColors.lightTextColor, fontSize:15.sp, fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
              ],
            ),

          ),
        ),


        SizedBox(height: 1.h,),


        Container(

          width: Device.width,
          alignment: Alignment.center,
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            color: AppColors.lightCardColor,
            borderRadius: BorderRadius.circular(15.sp),

          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text("Purchase ID".tr,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w700),),
                  SizedBox(width: 1.w,),
                  InkWell(
                      onTap: ()=> AppUtils.copyText(con.userId.value),
                      child: Icon(Icons.copy, color: AppColors.subTitleColor, size: 19.sp,)),

                ],
              ),
              SizedBox(height: 2.h,),
              Text(con.userId.value,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w500),),
            ],
          ),

        ),




      ],
    );
  }
}
