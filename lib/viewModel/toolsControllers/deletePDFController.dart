import 'dart:io';

import 'package:deletepdfpage/view/toolsScreens/deletePages/deletePages.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../../res/appStrings/appTools.dart';
import '../../utils/appUtils.dart';



class deletePDFController extends GetxController{



  var isLoad = false.obs;

  var range = TextEditingController();



  final rename = TextEditingController();



  RxList<int> selectedPages = <int>[].obs;




  deletePDF(PlatformFile file, name, totalPages,  context, isLight) async {
    try {


      if(selectedPages.length >= 1){

        isLoad.value = true;



        final deletePdfPath = await MethodChannel('pdf_utils').invokeMethod('removePages', {
          'filePath': file.path,
          'pages': selectedPages,
        });


        AppUtils.renameFile( name, deletePdfPath, AppTools.deletePages, context, isLight,);



        isLoad.value = false;



      }else{

        AppUtils.showMsg("Warning!", "Please select at least one page to delete.");


      }




    } catch (e) {
      isLoad.value = false;


      if (e.toString().contains("Bad user password. Password is not provided or wrong password provided.")) {
        AppUtils.showMsg("Warning!", "The chosen file is encrypted. Please try another file");
      }else{
        AppUtils.showMsg("Warning!", "The chosen file is Invalid. Please try another file");

        AppUtils.sendAnalyticsEvent(eventName: "DeletePDF_Error", clickedEvent: e.toString());

      }



      print(e);    }
  }


  /// Generate a list of even-numbered pages
   getEvenPages(int totalPages) {
     selectedPages.value = List.generate(totalPages ~/ 2, (index) => (index + 1) * 2);
  }

  /// Generate a list of odd-numbered pages
   getOddPages(int totalPages) {
    selectedPages.value = List.generate((totalPages + 1) ~/ 2, (index) => index * 2 + 1);
  }


  parseAndValidatePageRanges(String input, int totalPages, file, ) {

    List<int> pagesToRemove = [];
    bool isClear = true;

    // Split by comma and iterate over each part
   try{
     input.split(',').forEach((part) {
       part = part.trim(); // Remove spaces

       if (part.contains('-')) {
         // It's a range, e.g., "1-5"
         List<String> rangeParts = part.split('-');

         // Ensure range has exactly two numbers and they are valid
         if (rangeParts.length == 2) {
           int start = int.parse(rangeParts[0]);
           int end = int.parse(rangeParts[1]);

           // Validate: Start & End should be within total pages
           if (start >= 1 && end <= totalPages && start <= end) {
             pagesToRemove.addAll(List.generate(end - start + 1, (index) => start + index));
           } else {


             AppUtils.showMsg("Invalid Range", "'$part' is incorrect. Ensure the start page is smaller than the end page and within the total page count");
             isClear = false;

             // throw Exception("Invalid range: $part (Out of bounds or incorrect order)");

           }
         } else {

           AppUtils.showMsg("Invalid Range Format", "Please use the correct format like 1-5, 8, 12.");
           isClear = false;

         }
       } else {
         // It's a single number, validate it
         int page = int.parse(part);
         if (page >= 1 && page <= totalPages) {
           pagesToRemove.add(page);
         } else {

           AppUtils.showMsg("Invalid Range", "A page number '$page' exceeds the total number of pages in the PDF.");

           isClear = false;
           // throw Exception("Invalid page number: $page (Out of bounds)");
         }
       }
     });
   }catch(e){
     AppUtils.showMsg("Invalid Range Format", "Please use the correct format like 1-5, 8, 12.");

     isClear = false;

   }


    // print(pagesToRemove.toSet().toList());

    if (isClear) {
      selectedPages.value = pagesToRemove.toSet().toList(); // Remove duplicates if any
      Get.to(()=> deletePages(file: file, tPage: totalPages,));
    }

  }


}