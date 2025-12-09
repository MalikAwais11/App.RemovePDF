
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/assets.dart';
import '../res/appColors/appColors.dart';
import '../res/appUrls/appurls.dart';
import '../utils/apputils.dart';
import 'operationTile.dart';
import 'settingTile.dart';



class settingSheet extends StatefulWidget {
  const settingSheet({super.key});

  @override
  State<settingSheet> createState() => _settingSheetState();
}

class _settingSheetState extends State<settingSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Settings"),),
      body: Container(
        height: Device.height,
        decoration: BoxDecoration(
          color: AppColors.lightBgColor,
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(20.sp),topRight: Radius.circular(20.sp))
        ),


        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(height: 1.h,),


            settingTile(
              text: "Contact Support",
              img: Assets.imagesSupport,
              tap: (){


                AppUtils.sendMailFeedback();


              }, subtitle: "Need Help or Feedback? We’re Listening!",),

            SizedBox(height: 1.5.h,),



            //
            // settingTile(
            //   text: "Love the app?",
            //   subtitle: "Let the world know what you think!",
            //   img: Assets.imagesRate,
            //   tap: (){
            //
            //     AppUtils.RateUsToStore();
            //
            //   },
            // ),
            //
            // SizedBox(height: 1.5.h,),
            //
            //
            // settingTile(
            //     text: "Share the Love",
            //     subtitle: "Tell your friends about us.",
            //     img: Assets.imagesShare,
            //     tap: (){
            //
            //       AppUtils.ShareApp();
            //
            //     }),
            //
            // SizedBox(height: 1.5.h,),



            settingTile(
                text: "Discover More",
                img: Assets.imagesMoreApps,
                subtitle: "Check out our other cool apps.",
                tap: (){


                  AppUtils.OtherApps();



                }),


            SizedBox(height: 1.5.h,),

            settingTile(
                text: "Our Policy",
                subtitle: "Learn how we protect your data.",
                img: Assets.imagesPrivacy,
                tap: (){



                  AppUtils.privacyPolicy();


                }),


            SizedBox(height: 1.5.h,),

            settingTile(
                text: "Terms of Use",
                subtitle: "Explore the terms that keep us connected",
                img: Assets.imagesTerms,
                tap: (){

                  AppUtils.termsOfUse();


                }),


            SizedBox(height: 3.h,),



          ],
        ),
      ),
    );
  }
}