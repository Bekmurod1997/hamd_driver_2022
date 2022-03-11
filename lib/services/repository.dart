import 'package:flutter/cupertino.dart';
import 'package:hamd_driver/providers/all_orders_provider.dart';
import 'package:provider/provider.dart';

class Repository {
  Future<void> fetchOrders(BuildContext context) async {
    AllOrderProvider allOrderPrivder = Provider.of(context, listen: false);
    await allOrderPrivder.fetchAllOrders();
  }
}
