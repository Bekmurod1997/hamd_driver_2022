import 'package:flutter/material.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:hamd_driver/models/accepted_order_model.dart';

class MyOrdersProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Data> myOrders = [];

  Future<void> fetchMyOrders(String orderType) async {
    try {
      var response = await AllServices.fetchAllMyOrder(orderType);
      myOrders = response?.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
