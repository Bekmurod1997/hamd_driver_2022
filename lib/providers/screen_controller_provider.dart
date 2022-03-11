import 'package:flutter/material.dart';

class ScreenControllerProvider extends ChangeNotifier {
  int selectedScreen = 0;
  int screenChanger(int index) {
    selectedScreen = index;
    print('screen index value: $selectedScreen');
    notifyListeners();
    return selectedScreen;
  }
}
