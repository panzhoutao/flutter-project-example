import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@Description:
///@Author:         @Mr.pan
///@CreateDate:     2021/12/12
class MyThemeData {
  static MyThemeData get instance => _getInstance();

  static MyThemeData? _instance;

  MyThemeData._internal();

  static MyThemeData _getInstance() {
    return _instance ??= MyThemeData._internal();
  }

  ///primary padding
  EdgeInsetsGeometry get primaryPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);

  ///
  double get imageHeight => 65;

  ///
  static const systemBlueLight = Color(0xff007aff);
  static const systemBlack = Color(0xff000000);
  static const systemGray2Light = Color(0xffaeaeb2);
  static const disabledLight = Color(0xff999999);
  static const systemGray2Dark = Color(0xff636366);
  static const systemWhite = Color(0xffffffff);
  static const disabledDark = Color(0xff757575);
  static const systemGreenLight = Color(0xff34c759);
  static const systemGray6Light = Color(0xfff2f2f7);
  static const systemRedDark = Color(0xffff453a);
  static const systemGreenDark = Color(0xff30d158);
  static const systemGray4Light = Color(0xffd1d1d6);
  static const systemGray4Dark = Color(0xff3a3a3c);
  static const systemOrangeDark = Color(0xffff9f0a);
  static const systemGray3Light = Color(0xffc7c7cc);
  static const primaryColor = Color(0xffff9500);

  ///
  ThemeData themeData() {
    return ThemeData(
      primaryColor: primaryColor,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonThemeData,
      backgroundColor: systemGray6Light,
      dividerTheme: _dividerThemeData,
    );
  }

  ///
  ElevatedButtonThemeData get _elevatedButtonTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            return primaryColor;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            return systemWhite;
          }),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 14.w),
          ),
          textStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            );
          }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
      );

  ///
  AppBarTheme get _appBarTheme => const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      );

  ///
  TextButtonThemeData get _textButtonThemeData => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return null;
            }
            return primaryColor;
          }),
        ),
      );

  ///
  DividerThemeData get _dividerThemeData => const DividerThemeData(
        thickness: 1,
      );
}
