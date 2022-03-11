import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LanguageChoiceProvider extends ChangeNotifier {
  void changeLanguage(var param1, var param2) {
    var locale = Locale(param1, param2);
    Get.updateLocale(locale);
    notifyListeners();
  }
}
