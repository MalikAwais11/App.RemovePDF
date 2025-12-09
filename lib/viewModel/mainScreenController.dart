import 'dart:io';

import 'package:deletepdfpage/view/toolsScreens/deletePages/chooseTypeScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


import '../res/appStrings/appTools.dart';
import '../res/appUrls/appUrls.dart';
import '../utils/appUtils.dart';
import '../view/mainScreen/widgets/permissionSheet.dart';
import '../view/toolActivityScreen/toolActivityScreen.dart';


class mainScreenController extends GetxController {



  checkPermission(toolID, context) async {




    if(Platform.isIOS){
      pickFile(toolID, 0);

    }
    else{

      final status = await  Permission.storage.request();

      if(status.isGranted){



        // if(!await Directory(AppUrls.basePAth).exists()){
        //
        //   await Directory(AppUrls.basePAth).create();
        //
        // }


        pickFile(toolID, 0);



      }
      else if(status.isDenied){


        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

        final androidInfo = await deviceInfo.androidInfo;


        if(androidInfo.version.sdkInt > 31){

          // if(!await Directory(AppUrls.basePAth).exists()){
          //
          //   await Directory(AppUrls.basePAth).create();
          //
          // }

          pickFile(toolID, 0);


        }

        else{



          print("show Sheet");
          print("Denied");


          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              constraints: BoxConstraints(
                maxWidth: Device.width,
              ),
              context: context, builder: (context){
            return permissionSheet(toolId: toolID, isDenied: true, );
          });


        }


      }
      else if(status.isPermanentlyDenied){

        print("show Sheet");
        print("PermanentlyDenied");



        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            constraints: BoxConstraints(
              maxWidth: Device.width,
            ),
            context: context, builder: (context){
          return permissionSheet(toolId: toolID, isDenied: false, );
        });

      }

    }




  }


  List<PlatformFile>? files = [];

  PlatformFile? file;


  void pickFile(toolID, times) async{


    try{

      // int maxFileSizeInBytes = 30 * 1048576; //2 MB
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
          allowMultiple: toolID == AppTools.mergePdf ? true : false

      );
      if(result != null)
      {

        // if(toolID == AppTools.mergePdf){
        //
        //
        //   if(times == 0){
        //     files = [];
        //
        //
        //     files = result.files.map((e) => e).toList();
        //
        //     if(files!.length > 1){
        //
        //
        //       // Get.to(()=> mergePDF(files: files!));
        //
        //
        //       Get.to(()=> toolActivityScreen(toolId:  toolID, tPage: 0, file: files));
        //
        //       // Get.to(()=> toolActivityScreen(files: files!));
        //
        //
        //
        //     }
        //     else{
        //
        //
        //       AppUtils.showMsg("Warning!".tr, "Please choose more than one file".tr);
        //
        //
        //
        //     }
        //
        //
        //   }
        //   else{
        //
        //
        //     Get.back();
        //
        //     List<PlatformFile>? more = result.files.map((e) => e).toList();
        //
        //
        //     print("More");
        //
        //     print(files!.length);
        //     print(more.length);
        //
        //     files = files! + more;
        //
        //
        //     print(files!.length);
        //
        //
        //     Get.to(()=> toolActivityScreen(toolId:  toolID, tPage: 0, file: files));
        //
        //
        //     // Get.to(()=> mergePDF(files: files!));
        //
        //
        //   }
        //
        // }
        // else if(toolID == AppTools.readPdf){
        //   file = result.files.first;
        //
        //
        //   // Get.to(()=> pdfViewer(filePath: file!.path, type: AppTools.readPdf,));
        //   Get.to(()=> toolPagePreviewScreen(file: File(file!.path!), type: AppTools.readPdf,));
        //
        // }
        //
        //
        //
        // else{


          file = result.files.first;
          // var fileSize = await file!.size;


          int tPage =  await AppUtils.getPDFPageCount(file!.path!);


          if(tPage >= 2){

            Get.to(()=> chooseTypeScreen(tPages: tPage, file: file!));
            // Get.to(()=> toolActivityScreen(toolId:  toolID, tPage: tPage, file: file!));

          }else{


            AppUtils.showMsg("Warning!".tr, "Please select a PDF that contains at least two pages to proceed with page removal.".tr);


          }


        }


      // }
      else {
        // User canceled the picker
      }

    }catch (e){

      if (e.toString().contains("password required or incorrect password".tr)) {


        if(toolID == AppTools.unLockPDF) {



          Get.to(()=> toolActivityScreen(toolId:  toolID, tPage: 0, file: file!));



        }
        else {
          AppUtils.showMsg("Warning!".tr,
              "The chosen file is encrypted. Please try another file".tr);
        }

      }else{
        AppUtils.showMsg("Warning!".tr, "The chosen file is Valid. Please try another file".tr);


      }



    }


  }


  void pickImages() async{




    // final result = await ImagePicker().pickMultiImage();
    //
    //
    // if(result.length != 0){
    //
    //
    //
    //   List<File>? files = [];
    //
    //   files = result.map((f) => File(f.path)).toList();
    //
    //
    //
    //   // Get.to(()=> imageToPDF(files: files!,));
    //
    //   Get.to(()=> toolActivityScreen(toolId:  AppTools.imagesToPDF, tPage: 0, file: files));
    //
    //
    //
    //
    // }
    // else {
    //   // User canceled the picker
    // }


  }





}