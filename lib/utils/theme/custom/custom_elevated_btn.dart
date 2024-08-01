import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';

class TElevetedButtonTheme {
  TElevetedButtonTheme._();

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.grey.shade200,
      backgroundColor: BAppColor.kPrimaryColor,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Color(0xFFC4C4C4),
      side: BorderSide(color: BAppColor.kPrimaryColor),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: TextStyle(
          fontSize: 16, color: BAppColor.kbgColor, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Color(0xFFF6F6F6),
      backgroundColor: Theme.of(Get.context!).cardColor,
      disabledForegroundColor: Color(0xFF939393),
      disabledBackgroundColor: Color(0xFF4F4F4F),
      side: BorderSide(color: BAppColor.kPrimaryColor),
      padding: const EdgeInsets.symmetric(vertical: 16),
      textStyle: TextStyle(
          fontSize: 16, color: BAppColor.kbgColor, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}
