import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/providers/income_provder.dart';
import 'package:hamd_driver/providers/my_orders_provider.dart';
import 'package:hamd_driver/providers/plastic_card_provider.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:hamd_driver/screens/income/income_screen.dart';
import 'package:hamd_driver/screens/my_drawer/widgets/menu_options.dart';
import 'package:hamd_driver/screens/my_drawer/widgets/user_info.dart';
import 'package:hamd_driver/screens/my_order/my_order_screen.dart';
import 'package:hamd_driver/screens/profile_settings/profile_settings_screen.dart';
import 'package:hamd_driver/screens/settings/setting_screen.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class MyDrewer extends StatefulWidget {
  @override
  State<MyDrewer> createState() => _MyDrewerState();
}

class _MyDrewerState extends State<MyDrewer> {
  bool addingMoney = false;
  String errorMessage = '';
  final addSumController = TextEditingController();
  final _controller = TextEditingController();
  static const _locale = 'en';
  final formatCurrency = NumberFormat.decimalPattern();
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final _scaffoldKey2 = GlobalKey<ScaffoldState>();
  void _validateMoneyTransfer() {
    final FormState? form = _formKey2.currentState;
    if (form!.validate()) {
      print('form is valid');
    } else {
      print('form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: _scaffoldKey2,
      child: Form(
        key: _formKey2,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 45,
              left: 17,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfo(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuOptions(
                        title: 'mainMeny',
                        onpress: () {
                          Get.back();
                        },
                      ),
                      const Divider(
                        color: Color(0xffEAECF1),
                        thickness: 2.0,
                      ),
                      MenuOptions(
                        title: 'myOrders',
                        onpress: () {
                          Get.to(MyOrdersScreen());
                          context.read<MyOrdersProvider>().fetchMyOrders('day');
                        },
                        // onpress: () => Get.back(),
                      ),
                      const Divider(
                        color: Color(0xffEAECF1),
                        thickness: 2.0,
                      ),

                      MenuOptions(
                        title: 'myIncome',
                        // onpress: () => Get.back(),
                        onpress: () {
                          Get.to(
                            IncomeSreen(),
                          );
                          context.read<IncomeProvider>().fetchMyIncome('day');
                        },
                      ),

                      const Divider(
                        color: Color(0xffEAECF1),
                        thickness: 2.0,
                      ),
                      MenuOptions(
                        title: 'settings',
                        // onpress: () => Get.back(),
                        onpress: () => Get.to(
                          SettingScreen(),
                        ),
                      ),
                      const Divider(
                        color: Color(0xffEAECF1),
                        thickness: 2.0,
                      ),
                      // MenuOptions(
                      //   title: 'Мой профиль',
                      //   onpress: () => Get.to(ProfileSettings()),
                      // ),
                      Consumer<ProfileFetchProvider>(
                        builder: (context, userInfo, child) {
                          return MenuOptions(
                            title: 'myProfile',
                            onpress: () {
                              Get.to(() => ProfileSettingsScreen(
                                    userName: userInfo.userInfo?.name ?? '',
                                  ));
                              // context
                              //     .read<ProfileFetchProvider>()
                              //     .fetchUserInfo();
                              // context
                              //     .read<PlasticCardProvider>()
                              //     .fetchPlasticCard();
                            },
                            // onpress: () => Get.to(ProfileSettingsScreen()),
                          );
                        },
                      ),

                      // MenuOptions(
                      //   title: 'Моя карта',
                      //   onpress: () {
                      //     Get.to(MyPlasticCard());
                      //   },
                      // ),

                      const Divider(
                        color: Color(0xffEAECF1),
                        thickness: 2.0,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Consumer2<ProfileFetchProvider, PlasticCardProvider>(
                    builder: (context, userInfo, plastic, child) {
                  return userInfo.isLoading || plastic.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'myBalance'.tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      formatCurrency.format(
                                              userInfo.userInfo!.balance) +
                                          // ' ${userInfo.userInfo!.balance.toString()}' +
                                          'sum'.tr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    plastic.myPlastic.isEmpty
                                        ? showDialog(
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () => Get.back(),
                                                child: AlertDialog(
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(
                                                          height: 20),
                                                      Text(
                                                          'pleaseAddPlasticCard'
                                                              .tr),
                                                      const SizedBox(
                                                          height: 20),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : showDialog(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                  builder: (context, setState) {
                                                return AlertDialog(
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          'pleaseEnterSumOfMoney'
                                                              .tr),
                                                      const SizedBox(
                                                          height: 20),
                                                      TextFormField(
                                                        // validator: (value) {
                                                        //   if (value == '' || value.isEmpty ||  ) {
                                                        //     setState(() {
                                                        //       errorMessage =
                                                        //           'fieldCannotBeEmpty'
                                                        //               .tr;
                                                        //     });
                                                        //     return '';
                                                        //   }
                                                        //   return null;
                                                        // },
                                                        controller: _controller,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (string) {
                                                          // if (string == '') {
                                                          //   setState(() {
                                                          //     errorMessage =
                                                          //         'fieldCannotBeEmpty'
                                                          //             .tr;
                                                          //   });
                                                          // }
                                                          print(
                                                              'the vlue $string');
                                                          print(
                                                              'the controller ${_controller.value.text.replaceAll(',', '')}');
                                                          string =
                                                              '${_formatNumber(string.replaceAll(',', ''))}';
                                                          _controller.value =
                                                              TextEditingValue(
                                                            text: string,
                                                            selection: TextSelection
                                                                .collapsed(
                                                                    offset: string
                                                                        .length),
                                                          );
                                                        },
                                                      ),
                                                      Text(
                                                        errorMessage,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: ColorPalatte
                                                              .strongRedColor,
                                                        ),
                                                      ),
                                                      errorMessage.isEmpty
                                                          ? Container()
                                                          : const SizedBox(
                                                              height: 10),
                                                      const SizedBox(
                                                          height: 20),
                                                      Center(
                                                        child: TextButton(
                                                            onPressed:
                                                                () async {
                                                              if (_controller
                                                                  .text
                                                                  .isEmpty) {
                                                                setState(() {
                                                                  errorMessage =
                                                                      'fieldCannotBeEmpty'
                                                                          .tr;
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  addingMoney =
                                                                      true;
                                                                });

                                                                await AllServices
                                                                    .addMoney(
                                                                  sumOfMoney: _controller
                                                                      .text
                                                                      .replaceAll(
                                                                          ',',
                                                                          ''),
                                                                  cardId: plastic
                                                                      .myPlastic
                                                                      .first
                                                                      .id
                                                                      .toString(),
                                                                );
                                                                setState(() {
                                                                  addingMoney =
                                                                      false;
                                                                });
                                                                Get.back();
                                                                context
                                                                    .read<
                                                                        ProfileFetchProvider>()
                                                                    .fetchUserInfo();
                                                              }
                                                            },
                                                            child: addingMoney
                                                                ? CircularProgressIndicator()
                                                                : Text(
                                                                    'addSum'.tr,
                                                                  )),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                            });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: ColorPalatte.strongRedColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'addBalance'.tr,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ]),
                        );
                }),
                // const Divider(
                //   color: Color(0xffEAECF1),
                //   thickness: 2.0,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextButton(
                    onPressed: () {},
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Версия 1.0',
                        style: FontStyles.regularStyle(
                          fontSize: 10,
                          fontFamily: 'Ubuntu',
                          color: const Color(0xff232323),
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
    );
  }
}
