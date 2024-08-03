import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

const Color kbgColor = Color(0xffe5e5e5);
final LinearGradient color = LinearGradient(
  colors: [
    const Color(0xFF1A2B3D).withAlpha(200),
    const Color(0xffe5e5e5),
  ],
);

Color kSecondDarkColor = const Color(0xff474555);
Color kThirdDarkColor = const Color(0xff25243F);
Color kJtechPrimaryColor = const Color(0xff3E3C59);
Color kJtechSecondColor = const Color(0xffEE4062);
Color kJtechShadowColor = const Color(0xffFAF8FF);

class Themes {
  static Color kSecondDarkColor = const Color(0xffFAF8FF); // 0xff474555
  static final lightMode = ThemeData(
    useMaterial3: true,
    fontFamily: 'Metrophobic',
    scaffoldBackgroundColor: Color(0xffFAF8FF), //kbgColor,0xffF6F6F6
    primaryColor: BAppColor.kDarkSecondColor,
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      backgroundColor: kJtechShadowColor.withOpacity(0.2),
    ),
    //inputDecorationTheme: TTextFeildTheme.lightInputDecurationTheme,

    //elevatedButtonTheme: TElevetedButtonTheme.lightElevatedButtonTheme,
  );
  static Color kJtechPrimaryColor = const Color(0xff3E3C59);

  static final darkMode = ThemeData(
    fontFamily: 'Metrophobic',
    useMaterial3: true,
    scaffoldBackgroundColor: BAppColor.kDarkbgColor, // const Color(0xff181D2D),
    cardColor: const Color(0xff2D3250), //const Color(0xff1D2335),
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
      backgroundColor: kThirdDarkColor.withOpacity(0.4),
    ),

    // inputDecorationTheme: TTextFeildTheme.darkInputDecurationTheme,
    // appBarTheme: const AppBarTheme(
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.light,
    //     statusBarColor: Colors.transparent,
    //   ),
    // ),

    //elevatedButtonTheme: TElevetedButtonTheme.lightElevatedButtonTheme,
  );
}
