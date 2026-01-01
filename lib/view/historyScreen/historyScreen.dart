import 'dart:io';

import 'package:deletepdfpage/components/bannerAd.dart';
import 'package:deletepdfpage/generated/assets.dart';
import 'package:deletepdfpage/view/previewScreens/pdfViewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../res/appColors/appColors.dart';
import '../../res/appStrings/appTools.dart';
import '../../utils/appUtils.dart';
import '../../viewModel/historyController.dart';
import '../../viewModel/themeController.dart';
import '../mainScreen/mainScreen.dart';
import '../previewScreens/toolPagePreviewScreen.dart';


class historyScreen extends StatefulWidget {
  const historyScreen({super.key});

  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen> {

  final con = Get.put(historyController());
  final themeCon = Get.put(themeController());

  @override
  void initState() {
    con.getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Obx(() =>  con.itemsLength.value > 0 ?

            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Recent Files".tr,
                    style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800, color: themeCon.isLightTheme.value? AppColors.lightTextColor: AppColors.darkTextColor),
                  ),
                ),
                Center(
                  child: Text("Slide left to delete recent file".tr,
                    style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color:  AppColors.subTitleColor ),),
                ),
              ],
            ) :  SizedBox() ),

            SizedBox(height: 1.h,),

            Expanded(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: con.itemsLength.value,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, i){

                    return  Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart, // or other DismissDirection values
                      background: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.sp),
                          ),
                          margin: EdgeInsets.zero,
                          child: Container(
                              alignment: Alignment.center,
                              height: 8.h,
                              padding:  EdgeInsets.only(left: 12.sp, right: 5.sp,),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.sp),
                                  color: AppColors.themeColor
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 14.0),
                                    child: InkWell(
                                        onTap: (){
                                          con.deleteItem(con.items[i].id!);
                                        },
                                        child: Icon(Icons.delete, size: 23.sp, color: AppColors.darkTextColor,)),
                                  ),
                                ],
                              )


                          ),
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        con.deleteItem(con.items[i].id!);
                      },
                      child: InkWell(
                        onTap: () async {


                          if(await File(con.items[i].filePath!).exists()){


                            Get.to(()=> pdfViewer(filePath:con.items[i].filePath!, type: con.items[i].toolName,));


                          }else{

                            AppUtils.showMsg("Not Found!".tr, "The file may be corrupted or missing".tr);



                          }

                        },
                        child: Padding(
                          padding:  EdgeInsets.only(top: 12.sp),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.sp),
                            ),
                            margin: EdgeInsets.zero,
                            child: Container(
                              // color: AppColors.themeColor,
                              alignment: Alignment.topLeft,
                              height: 7.5.h,
                              padding:  EdgeInsets.only(left: 12.sp, right: 5.sp,),

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.sp),
                                  color: themeCon.isLightTheme.value? AppColors.lightCardColor : AppColors.darkCardColor
                              ),
                              // padding: EdgeInsets.only(left:device.setPadding(5),right:device.setPadding(2),top:device.setPadding(2),bottom:device.setPadding(2),),
                              child: Row(
                                children: [


                                  SizedBox(width:0.5.w,),
                                  Image.asset(Assets.imagesPDF, width: 8.w,),
                                  SizedBox(width:2.w,),
                                  Container(
                                    width: 5.sp, height: 5.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.themeColor,
                                      borderRadius: BorderRadius.circular(15.sp)
                                    ),
                                  ),
                                  SizedBox(width:2.w,),
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(AppUtils.getFileName(File(con.items[i].filePath.toString())),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                color: themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor
                                            ),
                                          ),
                                          SizedBox(height: 0.5.h,),
                                          Text(
                                            con.items[i].toolName == AppTools.splitPdf? "Split PDFs: ${con.items[i].splitPaths!.split(",").length} ${con.items[i].splitPaths!.split(",").length > 1? "Files".tr : "File".tr}":
                                            "File Size: ".tr+con.items[i].fileSize.toString(),

                                            style: TextStyle(
                                                fontSize: 14.5.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.themeColor

                                              // color: themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor

                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(width:2.w,),



                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    );

                  },

                ),
              ),
            ),
          ],
        ));
  }
}
