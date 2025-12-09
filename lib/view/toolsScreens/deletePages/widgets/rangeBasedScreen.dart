import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/themeButton.dart';
import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/toolsControllers/deletePDFController.dart';
import '../deletePages.dart';

class rangeBasedScreen extends StatefulWidget {

  final PlatformFile file;
  final tPage;
  const rangeBasedScreen({super.key, required this.file, required this.tPage});

  @override
  State<rangeBasedScreen> createState() => _rangeBasedScreenState();
}

class _rangeBasedScreenState extends State<rangeBasedScreen> {

  final con = Get.put(deletePDFController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Range Based"),),
      body: Padding(
        padding:  EdgeInsets.all(12.sp),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Total PDF Pages: "+widget.tPage.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14.sp,
                              color:  AppColors.themeColor
                          ),),
              
              
                        // widget.val == widget.selectVal? Icons.check_circle_rounded :
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 8.h,
                      padding:  EdgeInsets.only(left: 13.sp, right: 13.sp,),
              
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp),
                          color: AppColors.lightCardColor
                        // color: AppColors.darkBgColor
                      ),
                      child: TextField(
                        controller: con.range,
                        keyboardType: Platform.isIOS?  TextInputType.streetAddress :  TextInputType.phone,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17 .sp,
                          color:   AppColors.lightTextColor ,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9\\-\\,]+'))
                        ],
                        decoration: InputDecoration(
              
                          counterText: "",
                          contentPadding: EdgeInsets.only(left: 8),
                          hintText: "Ex: 1-5,8,11-13",
                          hintStyle: TextStyle(
                              color: AppColors.subTitleColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
              
                          fillColor: AppColors.lightBgColor,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.sp),
                            borderSide:  BorderSide(
                                color:  AppColors.lightBgColor
                            ),
                          ),
                          filled: false,
                          enabledBorder: OutlineInputBorder(
              
                            borderRadius: BorderRadius.circular(15.sp),
                            borderSide:  BorderSide(
                                color: AppColors.lightBgColor
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  Text("Enter page numbers or ranges separated by commas (e.g., 1-5,8,11-13) to remove specific pages from your PDF",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.subTitleColor, fontSize: 15.sp, fontWeight: FontWeight.w500),
                  )
                ]
              ),
            ),

            themButton(
                text: "Preview".tr,
                bgColor: AppColors.themeColor,
                textColor: AppColors.darkTextColor,
                height: 6.5.h,
                width: Device.width,
                onTap: () {

                  con.parseAndValidatePageRanges(con.range.text,widget.tPage, widget.file);



                }
            ),

            SizedBox(height: 2.5.h,),


          ],
        ),
      )
    );

  }
}
