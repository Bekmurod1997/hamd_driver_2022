import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/providers/language_choise_provider.dart';
import 'package:hamd_driver/screens/auth/auth_screen.dart';
import 'package:hamd_driver/screens/landing/widget/language_choice.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  final locales = [
    {'name': 'Uzbek', 'locale': Locale('uz', 'Uz')},
    {'name': 'Russian', 'locale': Locale('ru', 'RU')},
  ];
  updateLocale(Locale locale) {
    Get.updateLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenSize.height * 0.25,
                right: screenSize.width * 0.24,
                left: screenSize.width * 0.24),
            child: Image.asset('assets/images/logo.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 67),
                  child: LanguageChoosing(
                    function: () {
                      Provider.of<LanguageChoiceProvider>(context,
                              listen: false)
                          .changeLanguage('ru', 'RU');
                      MyPref.driverLang = 'ru';
                      print(MyPref.driverLang);
                      // MyPref.driverLang = 'ru';
                      // updateLocale(locales[1]['locale']);
                      Get.to(() => AuthScreen());
                    },
                    iconName: 'assets/icons/russia.svg',
                    text: 'Русский язык',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                LanguageChoosing(
                  function: () {
                    Provider.of<LanguageChoiceProvider>(context, listen: false)
                        .changeLanguage('uz', 'UZ');

                    MyPref.driverLang = 'uz';
                    print(MyPref.driverLang);
                    // updateLocale(locales[0]['locale']);
                    Get.to(() => AuthScreen());
                  },
                  iconName: 'assets/icons/uzbekistan.svg',
                  text: 'O\'zbek tili',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
