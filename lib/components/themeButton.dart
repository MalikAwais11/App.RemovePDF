import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class themButton extends StatelessWidget {
  final text;
  final bgColor;

  final textColor;
  final height;
  final width;
  final onTap;
  const themButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.height,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15.sp)
        ),
        child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: textColor, fontSize: 18.sp, fontWeight: FontWeight.w800),),

      ),
    );
  }
}
