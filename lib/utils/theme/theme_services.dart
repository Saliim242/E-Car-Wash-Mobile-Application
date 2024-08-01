import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ServicesThemes {
  final _box = GetStorage();
  final _keyValue = 'isDarkMode';

  _saveThemeMode(bool isDarkMode) => _box.write(_keyValue, isDarkMode);

  bool _isLoadingTheme() => _box.read(_keyValue) ?? false;

  ThemeMode get theme => _isLoadingTheme() ? ThemeMode.dark : ThemeMode.light;

  void changeThemeDynamically() {
    Get.changeThemeMode(_isLoadingTheme() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeMode(!_isLoadingTheme());
  }
}
