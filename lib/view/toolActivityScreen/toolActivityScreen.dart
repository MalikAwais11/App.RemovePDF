import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../res/appStrings/appTools.dart';
import '../toolsScreens/deletePages/deletePages.dart';



class toolActivityScreen extends StatefulWidget {

  final toolId;
  final tPage;
  final  file;

  toolActivityScreen({Key? key, required this.toolId, required this.tPage, required this.file}) : super(key: key);

  @override
  State<toolActivityScreen> createState() => _toolActivityScreenState();
}


class _toolActivityScreenState extends State<toolActivityScreen> {



  Widget getTool(type){

    switch (type) {


      case AppTools.deletePages:
        return deletePages(file: widget.file, tPage: widget.tPage,);


      default:
      // Code to execute if none of the cases match the expression
    }

    return Container();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: false, title: Text(widget.toolId.toString().tr),
      ),

      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child:  getTool(widget.toolId)
      ),
    );
  }
}