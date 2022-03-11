import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/locales/string_translations.dart';
import 'package:hamd_driver/providers/all_accepted_orders_provider.dart';
import 'package:hamd_driver/providers/all_orders_provider.dart';
import 'package:hamd_driver/providers/income_provder.dart';
import 'package:hamd_driver/providers/language_choise_provider.dart';
import 'package:hamd_driver/providers/my_orders_provider.dart';
import 'package:hamd_driver/providers/plastic_card_provider.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:hamd_driver/providers/screen_controller_provider.dart';
import 'package:hamd_driver/screens/landing/landing_screen.dart';
import 'package:hamd_driver/screens/main_orders/main_orders_screen.dart';
import 'package:hamd_driver/services/pushnotification.dart';
import 'package:hamd_driver/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  await await PushNotificationService.initializeApp();
  runApp(const MyApp());

  // await PushNotificationService.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AllOrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileFetchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScreenControllerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageChoiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AllAcceptedOrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => IncomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MyOrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileFetchProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PlasticCardProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileFetchProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ColorPalatte.strongRedColor,
            secondary: ColorPalatte.strongRedColor,
          ),
          primarySwatch: Colors.blue,
        ),
        home: Initializer(),
        translations: StringTranslations(),
        locale: Locale("uz", "UZ"),
        fallbackLocale: Locale("uz", "UZ"),
      ),
    );
  }
}

class Initializer extends StatefulWidget {
  @override
  _InitializerState createState() => _InitializerState();
}

class _InitializerState extends State<Initializer> {
  @override
  void initState() {
    print(MyPref.driverSecondToken);
    print(MyPref.driverToken);

    super.initState();
    var locale =
        MyPref.driverLang == "uz" ? Locale("uz", "UZ") : Locale("ru", "RU");
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return MyPref.driverSecondToken == ''
        ? LandingScreen()
        : MainOrdersScreen();
  }
}
