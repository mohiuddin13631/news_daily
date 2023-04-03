

import 'dart:ui';

import 'package:flutter/material.dart';

myTextStyle([double? size,FontWeight? fontWeight,Color? color]){
  return TextStyle(color:color?? Color(0xffe2dfdd),fontSize: size??16.0,fontWeight: fontWeight??FontWeight.normal,);
}

// myTextStyle([double? size,FontWeight? fw, Color? clr,]){
//   return TextStyle(
//     // fontFamily: 'myCustomFont',
//       fontSize: size??16.0,
//       color: clr??Colors.white,
//       fontWeight:fw?? FontWeight.w200
//   );
// }

Color bgColor = Color(0xff1b192e);