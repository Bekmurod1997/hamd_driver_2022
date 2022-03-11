import 'package:flutter/material.dart';
import 'package:hamd_driver/models/plastic_card_model.dart';
import 'package:hamd_driver/services/all_services.dart';

class PlasticCardProvider extends ChangeNotifier {
  List<Data> myPlastic = [];
  bool isLoading = true;

  void fetchPlasticCard() async {
    try {
      var response = await AllServices.fetchMyPlasticCard();
      myPlastic = response?.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
