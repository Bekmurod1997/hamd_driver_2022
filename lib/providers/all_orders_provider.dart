import 'package:flutter/material.dart';

import 'package:hamd_driver/models/all_orders_model.dart';
import 'package:hamd_driver/services/all_services.dart';

class AllOrderProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Data> allOrders = [];
  AllOrdersModel _allOrdersModel = AllOrdersModel(data: []);
  AllOrdersModel get allOrderModel => _allOrdersModel;
  set allOrderModel(AllOrdersModel allOrdersModel) {
    _allOrdersModel = allOrdersModel;
    notifyListeners();
  }

  Future<void> fetchAllOrders() async {
    allOrderModel = await AllServices.fetchAllOrdersProvider();
  }

  Future<void> fetchAllOrders2() async {
    try {
      var response = await AllServices.fetchAllOrdersProvider();
      allOrders = response.data ?? [];
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
