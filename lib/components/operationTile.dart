import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../res/appColors/appColors.dart';


class operationTile extends StatelessWidget {
  final text;
  final tap;
  const operationTile({super.key, required this.text,required this.tap,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 15.sp, right: 15.sp),
      child: InkWell(
        onTap: tap,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.sp)
          ),
          child: Container(
            height: 7.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.lightCardColor,
              borderRadius: BorderRadius.circular(15.sp)
            ),
            child:  Text(text,style: TextStyle(color: AppColors.themeColor, fontSize:17.5.sp, fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis),),

          ),
        ),
      ),
    );
  }
}
