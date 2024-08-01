import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'utils/constants/api_or_keys_constants.dart';
import 'utils/theme/theme_data.dart';
import 'utils/theme/theme_services.dart';

Future<void> main() async {
  await GetStorage.init();

  final box = GetStorage();

  await box.writeIfNull(onboarding, false);

  bool isIntro = box.read(onboarding);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Wash Application",
      initialRoute: !isIntro
          ? Routes.ONBOARDING
          : box.hasData(kUserInfo)
              ? AppPages.INITIAL
              : Routes.USER,
      //AppPages.INITIAL,
      theme: Themes.lightMode,
      // Themes.darkMode,
      darkTheme: Themes.darkMode,
      themeMode: ServicesThemes().theme,
      getPages: AppPages.routes,
    ),
  );
}
