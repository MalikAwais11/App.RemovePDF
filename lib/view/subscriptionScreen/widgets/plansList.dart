import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/AdsManager.dart';



class plansList extends StatefulWidget {
  const plansList({super.key});

  @override
  State<plansList> createState() => _plansListState();
}

class _plansListState extends State<plansList> {

  final con = Get.put(AdsManager());


  @override
  Widget build(BuildContext context) {

    return Obx(()=>
    con.plansList.length > 0?
        Column(
      children: [
        Container(

          height: 15.h,
          width: Device.width,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 1.w),
          decoration: BoxDecoration(
            // color: AppColors.themeColor
          ),

          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: con.plansList.length,
              itemBuilder: (ctx, i)=> InkWell(
                onTap: ()=> con.selectedPackage.value = i,
                child: Obx(()=>  Padding(
                  padding:  EdgeInsets.only(right: 12.sp),
                  child: Container(
                      width: 28.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(
                              color: con.selectedPackage.value == i? AppColors.themeColor : AppColors.subTitleColor,
                              width: 6.sp
                          )
                      ),
                      child: Column(
                        children: [


                          Expanded(child: Container(
                              alignment: Alignment.center,
                              child: Text("${con.plansList[i].storeProduct.priceString}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:  con.selectedPackage.value == i? AppColors.themeColor : AppColors.subTitleColor,
                                  fontSize: 16.sp,
                                  fontWeight: con.selectedPackage.value == i?FontWeight.w800 : FontWeight.w700,
                                ),)
                          )),

                          Container(
                              height: 4.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.sp),
                                    bottomRight: Radius.circular(15.sp),
                                  ),
                                  color:  con.selectedPackage.value == i? AppColors.themeColor : AppColors.lightCardColor,
                                  border: Border.all(
                                      color:  con.selectedPackage.value == i? AppColors.themeColor : Colors.transparent,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      width: 6.sp
                                  )
                              ),
                              alignment: Alignment.center,
                              child: Text("${

                                  con.plansList[i].packageType == PackageType.annual? "Yearly".tr :
                                  con.plansList[i].packageType == PackageType.monthly? "Monthly".tr :
                                  con.plansList[i].packageType == PackageType.weekly? "Weekly".tr :
                                  con.plansList[i].packageType == PackageType.twoMonth? "2 Months".tr:
                                  con.plansList[i].packageType == PackageType.threeMonth? "3 Months".tr :
                                  con.plansList[i].packageType == PackageType.sixMonth? "6 Months".tr
                                      : ""
                              }",
                                style: TextStyle(
                                  color:  con.selectedPackage.value == i? AppColors.darkTextColor : AppColors.subTitleColor,
                                  fontSize: 15.5.sp,
                                  fontWeight: con.selectedPackage.value == i? FontWeight.w800 :  FontWeight.w600,
                                ),)
                          ),


                        ],
                      )

                  ),
                )),
              )
          ),

        ),
        SizedBox(height: 4.h,),
        Obx(()=> Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
                style: TextStyle(color: AppColors.lightTextColor, fontSize: 16.sp, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: "You will be charged".tr+" "),
                  TextSpan(text: "${con.plansList[con.selectedPackage.value].storeProduct.priceString}", style: TextStyle(color: AppColors.themeColor, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  TextSpan(text: " "+"every".tr+" "),
                  TextSpan(text: "${ con.plansList[con.selectedPackage.value].packageType == PackageType.annual? "Year".tr : con.plansList[con.selectedPackage.value].packageType == PackageType.monthly? "Month".tr : con.plansList[con.selectedPackage.value].packageType == PackageType.weekly? "Week".tr : ""}",
                      style: TextStyle(color: AppColors.themeColor, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  TextSpan(text: "\n"+"automatically until you cancel.".tr),

                ]
            )
        )),

      ],
    )  :  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text("Heads up!".tr, style: TextStyle(color: AppColors.themeColor, fontSize: 17.sp, fontWeight: FontWeight.w700),),
        SizedBox(height: 1.h,),
        Text("We’re having trouble loading subscription plans. Please check your internet connection or try again shortly.".tr,
        style: TextStyle(color: AppColors.lightTextColor, fontSize: 17.sp, fontWeight: FontWeight.w700),
        ),

      ],
    ));



  }
}
