import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../res/appColors/appColors.dart';
import '../../../../../../viewModel/themeController.dart';




class selectedBtn extends StatefulWidget {
  final val;
  final selectVal;
  final tap;

  const selectedBtn({super.key, required this.val, required this.selectVal, required this.tap});

  @override
  State<selectedBtn> createState() => _selectedBtnState();
}

class _selectedBtnState extends State<selectedBtn> {

  final themeCon = Get.put(themeController());

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: widget.tap,
      child: Container(
        height: 6.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color:  widget.val == widget.selectVal? AppColors.themeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(13.sp)
        ),
        child: Text( "${widget.val}", style: TextStyle(color: widget.val == widget.selectVal?   (AppColors.darkTextColor) : (themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor), fontSize: 17.sp, fontWeight: FontWeight.w700),),

      ),
    );
  }
}
