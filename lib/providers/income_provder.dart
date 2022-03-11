import 'package:flutter/material.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:hamd_driver/models/income_model.dart';

class IncomeProvider extends ChangeNotifier {
  bool isLoading = true;
  Data? myIncomeList;

  void fetchMyIncome(String incomeType) async {
    try {
      var response = await AllServices.myIncomeService(incomeType);
      myIncomeList = response?.data;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
