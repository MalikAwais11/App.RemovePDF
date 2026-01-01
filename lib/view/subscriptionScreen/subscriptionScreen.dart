import 'package:deletepdfpage/view/subscriptionScreen/widgets/proButtons.dart';
import 'package:deletepdfpage/view/subscriptionScreen/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:deletepdfpage/res/appColors/appColors.dart';
import 'package:deletepdfpage/view/subscriptionScreen/widgets/plansDetails.dart';
import 'package:deletepdfpage/view/subscriptionScreen/widgets/plansList.dart';
import 'package:deletepdfpage/viewModel/AdsManager.dart';



class subscriptionScreen extends StatefulWidget {
  const subscriptionScreen({super.key});

  @override
  State<subscriptionScreen> createState() => _subscriptionScreenState();
}

class _subscriptionScreenState extends State<subscriptionScreen> {


  final con = Get.put(AdsManager());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,

            actions: [

              InkWell(
                  onTap: ()=>  Get.back(),
                  child: Icon(Icons.close, size: 22.sp,)
              ),

              SizedBox(width: 3.w,),

            ],

          ),
          body: Padding(
            padding:  EdgeInsets.only(left: 13.sp, right: 13.sp),
            child: Column(
              children: [



                proHeader(),



                Expanded(
                    child: Column(
                      children: [

                        Expanded(child: Obx(()=> con.isPro.value? plansDetails() : plansList() ),),
                        proButtons(),





                      ],
                    ))


              ],
            ),
          ),
        ),
        Obx(()=> con.isLoading.value?
        Positioned.fill(child: Container(

          height: Device.height,
          width: Device.width,
          color: Colors.black.withOpacity(0.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.themeColor,)
            ],
          ),
        )) : SizedBox())

      ],
    );
  }
}
