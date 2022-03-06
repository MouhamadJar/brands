import 'package:flutter/material.dart';

const kPrimaryTitleFontSize = 32.0;
const kTitleFontSize = 24.0;
const kSubTitleFontSize = 16.0;
const kPrimaryColor = Colors.white;
const kSecondColor = Color(0xFF27364D);
const kThirdColor = Color(0xFFA87839);

var token = '';
var name ='username';
var email ='username';
var image ='username';


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);