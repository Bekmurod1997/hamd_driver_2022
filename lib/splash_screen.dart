import 'package:flutter/material.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/screens/main_orders/main_orders_screen.dart';
import 'package:hamd_driver/services/repository.dart';
import 'package:flutter/cupertino.dart';
import 'providers/profile_fetch_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Repository repository = Repository();
  @override
  void initState() {
    print('token in splash screen');
    print(MyPref.driverSecondToken);
    print('this is initsate in splash screen');
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback(_callApi);
  }

  _gotToNextPage() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => MainOrdersScreen(),
      ),
    );
  }

  _callApi(_) {
    repository.fetchOrders(context);
    _gotToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
