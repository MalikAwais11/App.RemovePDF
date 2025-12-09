import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../res/appColors/appColors.dart';

class themeUtils{



  static ThemeData darkTheme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.darkBgColor,
      fontFamily: "Urbanist",
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
          toolbarHeight: 7.h,
          centerTitle: true,
          backgroundColor: AppColors.darkBgColor,
          elevation: 0,
          titleTextStyle: TextStyle(color: AppColors.darkTextColor, fontSize: 19.sp,fontWeight: FontWeight.w800,
              fontFamily: "Urbanist"
          ),
          iconTheme: IconThemeData(
              size: 22.sp,
              color: AppColors.darkTextColor
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          )
      )
  );
  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.lightBgColor,

      fontFamily: "Urbanist",
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      appBarTheme: AppBarTheme(
          toolbarHeight: 7.h,
          centerTitle: true,
          backgroundColor: AppColors.lightBgColor,
          elevation: 0,
          titleTextStyle: TextStyle(color: AppColors.lightTextColor, fontSize: 19.sp,fontWeight: FontWeight.w800,
              fontFamily: "Urbanist"

          ),
          iconTheme: IconThemeData(
              size: 22.sp,
              color: AppColors.lightTextColor
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          )
      )
  );

}
