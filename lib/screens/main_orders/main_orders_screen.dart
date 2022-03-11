import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hamd_driver/components/custom_appbar.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/providers/all_accepted_orders_provider.dart';
import 'package:hamd_driver/providers/all_orders_provider.dart';
import 'package:hamd_driver/providers/plastic_card_provider.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:hamd_driver/providers/screen_controller_provider.dart';
import 'package:hamd_driver/screens/main_orders/widgets/accepted_orders.dart';
import 'package:hamd_driver/screens/main_orders/widgets/all_orders_card.dart';
import 'package:hamd_driver/screens/my_drawer/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class MainOrdersScreen extends StatefulWidget {
  const MainOrdersScreen({Key? key}) : super(key: key);

  @override
  _MainOrdersScreenState createState() => _MainOrdersScreenState();
}

class _MainOrdersScreenState extends State<MainOrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void _openDrawer() {
    print('drawerr opening');
    context.read<ProfileFetchProvider>().fetchUserInfo();
    context.read<PlasticCardProvider>().fetchPlasticCard();
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    _firebaseMessaging.getNotificationSettings();
    _firebaseMessaging.requestPermission();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        badge: true, alert: true, sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      print('navvvvv');
      print(message.notification!.title);
      Get.snackbar(
        MyPref.driverLang == 'uz'
            ? 'Yangi buyurtma'
            : message.notification!.title!,
        MyPref.driverLang == 'uz'
            ? 'Sizda yangi buyurtma bor'
            : message.notification!.body!,
        backgroundColor: Color(0xff007E33),
      );
    });
    context.read<AllOrderProvider>().fetchAllOrders();
    context.read<AllAcceptedOrdersProvider>().fetchAllAcceptedOrders();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messag) {
      Get.offAll(() => MainOrdersScreen());
    });
    // TODO: implement initState
    super.initState();

    context.read<AllOrderProvider>().fetchAllOrders2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * .85,
          child: Drawer(
            child: MyDrewer(),
          ),
        ),
        appBar: PreferredSize(
          child: customAppBar(context,
              title: 'mainMeny'.tr,
              onpress1: () => _openDrawer(),
              icon: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 26,
                  ),
                  onPressed: _openDrawer)),
          preferredSize: Size.fromHeight(
              kToolbarHeight + MediaQuery.of(context).viewPadding.top),
        ),
        body: Consumer<ScreenControllerProvider>(
          builder: (context, screen, child) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    color: ColorPalatte.strongRedColor,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 3),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffC3696F),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: ColorPalatte.strongRedColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: RaisedButton(
                                elevation: 0,
                                color: screen.selectedScreen == 0
                                    ? Colors.white
                                    : Colors.transparent,
                                onPressed: () {
                                  screen.screenChanger(0);
                                  context
                                      .read<AllOrderProvider>()
                                      .fetchAllOrders2();
                                  // if (screenController.screenIndex.value == 1) {
                                  //   screenController.selectOne();
                                  // allOrdersController.fetchAllOrders();
                                  // print(selectedIndex.toString());
                                  // repository.fetchOrders(context);
                                  // }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Text(
                                  'allOrders'.tr,
                                  style: FontStyles.boldStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: screen.selectedScreen == 0
                                        ? Colors.black
                                        : const Color(
                                            0xffCDE8F4,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: RaisedButton(
                                elevation: 0,
                                color: screen.selectedScreen == 1
                                    ? Colors.white
                                    : Colors.transparent,
                                onPressed: () {
                                  screen.screenChanger(1);
                                  context
                                      .read<AllAcceptedOrdersProvider>()
                                      .fetchAllAcceptedOrders();
                                  // if (screenController.screenIndex.value == 0) {
                                  //   screenController.selectTwo();
                                  //   acceptedOrdersController
                                  //       .fetchAllAcceptedOrders();
                                  // }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                  'acceptedOrders'.tr,
                                  style: FontStyles.boldStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: screen.selectedScreen == 1
                                        ? Colors.black
                                        : const Color(
                                            0xffCDE8F4,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: screen.selectedScreen == 0
                      ? const AllOrdersScreen()
                      : const AcceptedOrders(),
                ),
              ],
            );
          },
        ));
  }
}
