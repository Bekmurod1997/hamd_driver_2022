import 'package:flutter/material.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:hamd_driver/models/accepted_order_model.dart';

class AllAcceptedOrdersProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Data> acceptedOrders = [];

  Future<AllAcceptedOrderModel?> fetchAllAcceptedOrders() async {
    try {
      var response = await AllServices.fetchAllAcceptedOrdersService();
      acceptedOrders = response?.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
