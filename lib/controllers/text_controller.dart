import 'package:brands_projects/component/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextController extends GetxController{

  Map<String,double> fontSize={
    'PRIMARY' : kPrimaryTitleFontSize,
    'TITLE' : kTitleFontSize,
    'SUB' :kSubTitleFontSize,
  };

  double? getSize(String type){
    return fontSize[type];
  }
  TextStyle getTextStyle({style}){
    return GoogleFonts.robotoMono(
      textStyle: style,
    );
  }
}