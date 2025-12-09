import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../res/appColors/appColors.dart';
import '../../../../viewModel/themeController.dart';



class toolCardItem extends StatefulWidget {

  final toolID;
  final toolImg;
  final tap;



  toolCardItem({super.key, required this.toolID,required this.toolImg,required this.tap,});

  @override
  State<toolCardItem> createState() => _toolCardItemState();
}

class _toolCardItemState extends State<toolCardItem> {

  final themeCon = Get.put(themeController());


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.tap,

      child: Container(
        height: 15.h,
        width: Device.width/3.4,
        decoration: BoxDecoration(
            color: themeCon.isLightTheme.value?  AppColors.lightCardColor : AppColors.darkCardColor,
            borderRadius: BorderRadius.circular(15.sp)
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 2.h,),
            Image.asset(widget.toolImg, width: 15.w,),

            SizedBox(height: 1.h,),

            Text(widget.toolID,
              maxLines: 2,
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15.5.sp,fontWeight: FontWeight.w800, color: themeCon.isLightTheme.value? AppColors.lightTextColor: AppColors.darkTextColor),)


          ],
        ),



      ),
    );
  }
}
