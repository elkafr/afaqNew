import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afaq/utils/app_colors.dart';

ThemeData themeData() {
  return ThemeData(
    primaryColor: cPrimaryColor,
    hintColor: cHintColor,
    brightness: Brightness.light,
    // buttonColor: cPrimaryColor,
    scaffoldBackgroundColor: Color(0xffFFFFFF),
    fontFamily: 'segoeui',
    tabBarTheme: TabBarThemeData(
      labelColor: Colors.white,
      labelStyle: TextStyle(color: Colors.red), // color for text

      indicator: UnderlineTabIndicator(
        // color for indicator (underline)
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    textTheme: TextTheme(
      // app bar style
      //   display1: TextStyle(color: cText, fontSize: 17,  fontFamily: 'segoeui',fontWeight: FontWeight.w600),

      // title of dialog
      //   title: TextStyle(
      //    fontFamily: 'segoeui', fontSize: 18, fontWeight: FontWeight.w600),

      // style info Text
      //   display2: TextStyle(
      //    color: cBlack,
      //    fontSize: 17,
      //    fontWeight: FontWeight.w400,
      //   height: 1.5),

      //  button: TextStyle(
      //    color: cWhite, fontWeight: FontWeight.w600, fontSize: 15.0)

      //         // title of dialog
      //         title: TextStyle(
      //             fontFamily: 'JF-Flat', fontSize: 18, fontWeight: FontWeight.w400),

      // // title of the page تسجيل جديد ،ملخص الفاتورة
      //         display1: TextStyle(
      //             fontFamily: 'JF-Flat',
      //             fontSize: 18,
      //             color: Colors.white,
      //             fontWeight: FontWeight.w500),

      // // title   رقم العمارة
      //         display2: TextStyle(
      //             fontSize: 16, fontFamily: 'Din-Next',
      //             fontWeight: FontWeight.w600,
      //             color: Color(0xff09929B)),

      //         display3: TextStyle(
      //             fontSize: 20,
      //             fontFamily: 'JF-Flat',
      //             color: Color(0xff09929B),
      //             fontWeight: FontWeight.w600), //
    ),
  );
}

CupertinoThemeData cupertinoTheme() {
  return CupertinoThemeData(
    primaryColor: Color(0xff44A73A),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xffFFFFFF),
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontFamily: 'segoeui'),
    ),
  );
}
