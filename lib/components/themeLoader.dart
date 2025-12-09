import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../res/appColors/appColors.dart';



class themeLoader extends StatelessWidget {
  const themeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      width: Device.width/1.1,
      padding: EdgeInsets.all(6.sp),
      decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(15.sp)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white,),
        ],
      ),
    );
  }
}
