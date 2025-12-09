import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../res/appColors/appColors.dart';
import '../../../../../viewModel/themeController.dart';

class optionTile extends StatefulWidget {
  String title;
  String subtitle;

  final tap;
   optionTile({super.key, required this.title,required this.subtitle, required this.tap, });

  @override
  State<optionTile> createState() => _optionTileState();
}

class _optionTileState extends State<optionTile> {


  final themeCon = Get.put(themeController());


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 18.sp),
      child: InkWell(
        onTap: widget.tap,
        child: Card(
          margin: EdgeInsets.zero,
          child: Container(
            // color: AppColors.themeColor,
            alignment: Alignment.centerLeft,
            height: 8.h,
            padding:  EdgeInsets.only(left: 5.w, right: 13.sp,),

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.sp),
                color: themeCon.isLightTheme.value? AppColors.lightCardColor : AppColors.darkCardColor
              // color: AppColors.darkBgColor
            ),
            // padding: EdgeInsets.only(left:device.setPadding(5),right:device.setPadding(2),top:device.setPadding(2),bottom:device.setPadding(2),),
            child: Row(
              children: [


                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( "➜ "+widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.themeColor
                        ),
                      ),
                      SizedBox(height: 0.5.h,),
                      Text(widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.5.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.subTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Text("➜",style: TextStyle(
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.w700,
                //     color: AppColors.themeColor
                // ),),
                SizedBox(width: 2.w,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
