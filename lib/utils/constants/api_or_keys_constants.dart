import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:ewash/utils/constants/app_colors.dart';

const String kEndPoint = 'https://e-wash.vercel.app/api/';
const String kUserInfo = "userInfo";
const String kCustomerInfo = "customer";
const String onboarding = "isOnboardSee";
const String kBannerLocalKey = "banners";
const double kPadding = 16.0;

// TextStyle Widger

TextStyle style({
  required double fontSize,
  String? fontFamily,
  required Color color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

Widget backArrow({Color? color, Color? color2}) {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Container(
      child: Icon(
        Iconsax.back_square,
        color: Get.isDarkMode
            ? color ?? BAppColor.kbgColor
            : color2 ?? BAppColor.kTextStyleColor,
      ),
    ),
  );
}

MoneyFormatterOutput moneyFormater(double money) {
  MoneyFormatterOutput fo =
      MoneyFormatter(amount: double.parse(money.toString())).output;

  return fo;
}

String formatAmout(double amount) {
  final format =
      NumberFormat.currency(locale: "en_US", symbol: "\$ ", decimalDigits: 2);

  return format.format(amount);
}

showToast({
  required String message,
  Toast? toastLength,
  ToastGravity? gravity,
  Color? backgroundColor,
  Color? textColor,
}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength ?? Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? BAppColor.kCheckOutInActiveBgColor,
    textColor: textColor ?? BAppColor.kCheckOutActiveTextColor,
    fontSize: 16.0,
  );
}
