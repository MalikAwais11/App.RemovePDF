import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../res/appColors/appColors.dart';


class settingTile extends StatelessWidget {
  final text;
  final subtitle;
  final img;
  final tap;
  const settingTile({super.key, required this.text,required this.subtitle,required this.img,required this.tap,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 15.sp, right: 15.sp),
      child: InkWell(
        onTap: tap,
        child: Container(
          height: 8.h,
          width: Device.width,

          padding: EdgeInsets.only(left: 5.w),
          decoration: BoxDecoration(
              color: AppColors.lightCardColor,
              borderRadius: BorderRadius.circular(15.sp)
          ),
          child: Row(
            children: [
              Image.asset(img, width: 6.7.w,),
              SizedBox(width: 4.w,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text,style: TextStyle(color: AppColors.lightTextColor, fontSize:16.5.sp, fontWeight: FontWeight.w700,),),
                    SizedBox(height: 0.5.h,),
                    Text(subtitle,style: TextStyle(color: AppColors.lightTextColor, fontSize:14.sp, fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
