import 'package:deletepdfpage/view/toolsScreens/deletePages/widgets/optionTile.dart';
import 'package:deletepdfpage/view/toolsScreens/deletePages/widgets/rangeBasedScreen.dart';
import 'package:deletepdfpage/viewModel/toolsControllers/deletePDFController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../res/appColors/appColors.dart';
import '../../../../../viewModel/themeController.dart';
import 'deletePages.dart';


class chooseTypeScreen extends StatefulWidget {

  final PlatformFile file;
  final int tPages;

  const chooseTypeScreen({super.key, required this.file, required this.tPages});


  @override
  State<chooseTypeScreen> createState() => _chooseTypeScreenState();
}

class _chooseTypeScreenState extends State<chooseTypeScreen> {



  final themeCon = Get.put(themeController());
  final con = Get.put(deletePDFController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: false, title: Text("Choose Option".tr),
      ),
      body: Container(
        color: AppColors.lightBgColor,
        child: Padding(
          padding: EdgeInsets.only(left: 13.sp, right: 13.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: 1.h,),

              optionTile(
                title: "Select & Preview Pages",
                subtitle: "Manually select pages with a preview before removal.",
                tap: (){
                  con.selectedPages.clear();
                  Get.to(()=> deletePages(file: widget.file, tPage: widget.tPages,));
                },
              ),

              optionTile(
                title: "Range-Based Page Removal",
                subtitle: "Remove pages using custom ranges like '1-5,7,9-15'.",
                tap: ()  {

                  Get.to(()=> rangeBasedScreen(file: widget.file, tPage: widget.tPages,));

                },
              ),

              optionTile(
                title: "Remove Even Pages",
                subtitle: "Quickly delete all even-numbered pages from the PDF.",
                tap: () async {

                  con.getEvenPages(widget.tPages);
                  Get.to(()=> deletePages(file: widget.file, tPage: widget.tPages,));

                },
              ),

              optionTile(
                title: "Remove Odd Pages",
                subtitle: "Easily remove all odd-numbered pages from the PDF.",
                tap: () async {

                  con.getOddPages(widget.tPages);
                  Get.to(()=> deletePages(file: widget.file, tPage: widget.tPages,));

                },
              ),

              // SizedBox(height: 1.h,),
              //
              // Text( "➜ More Tools",
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyle(
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w700,
              //       color: AppColors.lightTextColor
              //   ),
              // ),
              //
              //
              // SizedBox(height: 1.h,),

              SizedBox(height: 1.5.h,),

            ],
          ),
        ),
      ),
    );
  }
}
