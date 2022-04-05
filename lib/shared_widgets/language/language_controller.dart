import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  void changeLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (Get.locale.languageCode == "ar") {
      Get.updateLocale(Locale('en'.tr));
      // await box.write("LANG", 'en'.tr);
      sharedPreferences.setString("LANG", 'en'.tr);
    } else {
      Get.updateLocale(Locale('ar'.tr));
      // await box.write("LANG", 'en'.tr);
      sharedPreferences.setString("LANG", 'ar'.tr);
    }
  }
}
