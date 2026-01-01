import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/themeButton.dart';
import '../../../components/themeLoader.dart';
import '../../../res/appColors/appColors.dart';
import '../../../res/appStrings/appTools.dart';
import '../../../utils/appUtils.dart';
import '../../../viewModel/themeController.dart';
import '../../../viewModel/toolsControllers/deletePDFController.dart';


class deletePages extends StatefulWidget {
  final PlatformFile file;

  final tPage;
  const deletePages({super.key, required this.file, required this.tPage});

  @override
  State<deletePages> createState() => _deletePagesState();

}

class _deletePagesState extends State<deletePages> {




  final themeCon = Get.put(themeController());
  final con = Get.put(deletePDFController());




  @override
  void initState() {
    // con.selectedPages = [];
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Remove Pages"),),

      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [


            Text("Select a page to delete".tr,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color:  AppColors.subTitleColor ),),

            SizedBox(height: 1.5.h),

            Padding(
              padding:  EdgeInsets.only(left: 10.sp, right: 10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [


                  Expanded(
                    child: Text("Total PDF Pages: "+widget.tPage.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14.sp,
                          color:  AppColors.themeColor
                      ),),

                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                     Obx(()=>  Text("Selected Pages: "+con.selectedPages.length.toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.sp,
                       color: AppColors.themeColor,
                     ), ),),

                      SizedBox(width: 2.w,),

                      Obx(()=> InkWell(

                        onTap: (){


                          if(widget.tPage == con.selectedPages.length){

                            con.selectedPages.value = [];

                          }else{

                            con.selectedPages.value = [];

                            for(int i = 1 ; i <= widget.tPage; i++){

                              con.selectedPages.add(i);

                            }

                          }


                          // setState(() {});

                          con.selectedPages.refresh();

                        },
                        child: SizedBox(
                          child: Icon( widget.tPage == con.selectedPages.length? Icons.check_circle_rounded : Icons.circle_outlined, color:  AppColors.themeColor, size: 23.sp,),
                          width: 8.w,
                        ),
                      ),)

                    ],
                  )


                  // widget.val == widget.selectVal? Icons.check_circle_rounded :
                ],
              ),
            ),

            SizedBox(height: 1.5.h),


            Expanded(child:  GridView.builder(
              // shrinkWrap: true,
              itemCount: widget.tPage,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1.8.w,
                mainAxisSpacing: 0.3.h,
                crossAxisCount: 3,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (BuildContext context, int i){

                return Obx(()=> Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),

                    color: Colors.transparent,),
                  child: InkWell(

                    onTap: (){

                      if(con.selectedPages.any((e) => e == i+1)){
                        con.selectedPages.remove(i+1);
                        // debugPrint("removed ${i+1}");
                      }

                      else{

                        con.selectedPages.add(i+1);
                        // debugPrint("add  ${i+1}");
                      }

                      con.selectedPages.refresh();

                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [



                              Container(
                                height: Device.height,
                                width: Device.width/2,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.sp),

                                  color: Colors.transparent,
                                  // color: themeCon.isLightTheme.value? AppColors.lightCardColor : AppColors.darkCardColor,

                                ),
                                child: Card(

                                    color: themeCon.isLightTheme.value? AppColors.lightCardColor : AppColors.darkCardColor,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.sp)
                                    ),


                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.sp),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: PdfDocumentViewBuilder.file(
                                            widget.file.path!,
                                            builder: (context, document) => PdfPageView(
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                              ),

                                              document: document,
                                              pageNumber: i+1,

                                            )
                                        ),
                                      ),
                                    )

                                ),
                              ),

                              con.selectedPages.any((e) => e == i+1)?
                              Positioned.fill(

                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:  AppColors.themeColor.withOpacity(0.2) ,
                                      borderRadius: BorderRadius.circular(18.sp),
                                      border: Border.all(
                                        width: 0.5.w,
                                        color: AppColors.themeColor ,
                                      ),
                                    ),


                                  )) : Container()

                            ],
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius:14.sp,
                            backgroundColor: con.selectedPages.any((e) => e == i+1)? AppColors.themeColor: Colors.transparent,

                            child: Text( (i+1).toString(), textAlign: TextAlign.start, maxLines: 1, style: TextStyle(

                              color:  con.selectedPages.any((e) => e == i+1)? AppColors.darkTextColor : (themeCon.isLightTheme.value? AppColors.lightTextColor : AppColors.darkTextColor),

                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700,

                            ),),
                          ),
                        )
                      ],
                    ),

                  ),
                ));
              },
            )),


            SizedBox(height: 1.5.h,),




            Obx(() => con.isLoad.value?  themeLoader() :



            themButton(
                text: "Delete Pages".tr,
                bgColor: AppColors.themeColor,
                textColor: AppColors.darkTextColor,
                height: 6.5.h,
                width: Device.width,
                onTap: () {



                  if(con.selectedPages.length == widget.tPage){

                    AppUtils.showMsg("Warning!".tr, "You must keep at least one page in the PDF.".tr);


                  }else{

                    con.deletePDF(widget.file,
                        "${"${AppUtils.getFileName(widget.file)} ${AppTools.deletePages}_${DateTime.now().millisecond.toString()}"}".replaceAll(".pdf", ""),
                        widget.tPage, context, themeCon.isLightTheme.value);


                    // con.removePages(widget.file);

                  }



                }
            ),),


            SizedBox(height: 2.5.h,),

          ],
        ),
      ),
    );
  }
}
