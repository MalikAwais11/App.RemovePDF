import 'dart:async';
import 'package:deletepdfpage/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';


import '../../../res/appColors/appColors.dart';
import '../mainScreen/mainScreen.dart';


class Splash_Screen extends StatefulWidget {
  Splash_Screen({Key? key, }) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {


  @override
  void initState() {
    Timer(Duration(seconds: 3,), (){
      Get.offAll(()=>  mainScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
       gradient: LinearGradient(
         begin: Alignment.topLeft,
           end: Alignment.bottomRight,

           colors: [
             Color(0xffDB0000),
             Color(0xff750000),
           ]

       )
     ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.only(left: 10),
                  child: Image.asset(Assets.imagesDeleteSplash, width: Device.width/1.6),
                ),
              ),

              Text("Powered By", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp, color: AppColors.darkTextColor)),
              SizedBox(height: 0.5.h,),
              Text("Codify Apps", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17.5.sp, color: AppColors.darkTextColor)),

              SizedBox(height: 8.h,),

            ],
          ),
        ),
      ),
    );
  }
}

