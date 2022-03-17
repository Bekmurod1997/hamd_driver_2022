import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/components/dialog_wrong.dart';
import 'package:hamd_driver/constants/api.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/models/accepted_order_model.dart';
import 'package:hamd_driver/models/all_orders_model.dart';
import 'package:hamd_driver/models/code_confirm_model.dart';
import 'package:hamd_driver/models/income_model.dart';
import 'package:hamd_driver/models/plastic_card_model.dart';
import 'package:hamd_driver/models/plastic_card_verified_model.dart';
import 'package:hamd_driver/models/sign_in_model.dart';
import 'package:hamd_driver/providers/all_accepted_orders_provider.dart';
import 'package:hamd_driver/providers/plastic_card_provider.dart';
import 'package:hamd_driver/providers/screen_controller_provider.dart';
import 'package:hamd_driver/screens/auth/sms_screen.dart';
import 'package:hamd_driver/screens/main_orders/main_orders_screen.dart';
import 'package:hamd_driver/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class AllServices {
  static var client = http.Client();

  static Future<void> addMoney(
      {required String sumOfMoney, required String cardId}) async {
    final token = MyPref.driverSecondToken;

    try {
      var response = await client.post(
          Uri.parse('http://hamd.loko.uz/api/user/balance-add'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
          body: {
            'cash': sumOfMoney,
            'card_id': cardId,
          });
      if (response.statusCode == 200) {
        print('if sucess in addingMOney');
        print(response.body);
        print('success in making Bill');
      } else {
        print('this is else statement in makeMoney');
      }
    } catch (e) {
      print('error in making bill method');
      print(e);
    }
  }

  static Future<void> makeBill({required String orderId}) async {
    final token = MyPref.driverSecondToken;

    try {
      var response = await client.post(
          Uri.parse('http://hamd.loko.uz/api/order/set-receipt'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
          body: {
            'order_id': orderId,
          });
      if (response.statusCode == 200) {
        print('success in making Bill');
      }
    } catch (e) {
      print('error in making bill method');
      print(e);
    }
  }

  static Future<void> deletePlasticCard(
      BuildContext context, String plasticCardId) async {
    final token = MyPref.driverSecondToken;
    try {
      var response = await client.delete(
        Uri.parse('http://hamd.loko.uz/api/card/remove'),
        body: {
          'card_id': plasticCardId,
        },
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        context.read<PlasticCardProvider>().fetchPlasticCard();
        Get.back();
      }
    } catch (e) {
      print('error in deleting plastic card');
      print(e);
      Get.dialog(
        GestureDetector(
          onTap: () => Get.back(),
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(.1),
            body: Center(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  color: Colors.white,
                  width: double.infinity,
                  // height: 140.0,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.back();
                          //   },
                          //   child: Container(
                          //     alignment:
                          //         Alignment.topRight,
                          //     child: Icon(
                          //       Icons.cancel,
                          //       color:
                          //           ColorPalate.mainColor,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          Text('someThingWentWrong'.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 30),
                        ],
                      ),
                      Positioned(
                        top: 15,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.cancel,
                              color: ColorPalatte.strongRedColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      );
    }
  }

  static Future<PlasticCardVerifiedModel?> addPlasticCard(
      {required BuildContext context,
      required int typeId,
      required String cardNumber,
      required String cardPhoneNumber,
      required String cardExpire}) async {
    final token = MyPref.driverSecondToken;

    try {
      TextEditingController verifyNumber = TextEditingController();
      var response = await client
          .post(Uri.parse('http://hamd.loko.uz/api/card/send'), headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token'
      }, body: {
        'type_id': typeId.toString(),
        'card_number': cardNumber,
        'card_phone_number': cardPhoneNumber,
        'card_expire': cardExpire,
      });
      if (response.statusCode == 200) {
        var jsonString =
            PlasticCardVerifiedModel.fromJson(json.decode(response.body));

        MyPref.plasticCardId = jsonString.data!.id.toString();
        Get.back();
        Get.bottomSheet(
          StatefulBuilder(
            builder: (context, state) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'verifiyNumber'.tr,
                        style: FontStyles.mediumStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: const Color(0xff0E0E0E),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffE1E1E1),
                            )),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: verifyNumber,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () async {
                          print('verift button pressed');
                          try {
                            var res2 = await client.post(
                              Uri.parse(
                                  'http://hamd.loko.uz/api/card/send-verify-code'),
                              body: {
                                'card_id': MyPref.plasticCardId,
                                'code': verifyNumber.text,
                              },
                              headers: {
                                HttpHeaders.authorizationHeader: 'Bearer $token'
                              },
                            );
                            print(res2.request);
                            if (res2.statusCode == 200) {
                              context
                                  .read<PlasticCardProvider>()
                                  .fetchPlasticCard();
                              Get.back();
                              Get.snackbar(
                                "successfully saved plasticCard",
                                "",
                                icon: const Icon(Icons.person,
                                    color: Colors.white),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                borderRadius: 20,
                                margin: EdgeInsets.all(15),
                                colorText: Colors.white,
                                duration: Duration(seconds: 4),
                                isDismissible: true,
                                // dismissDirection: SnackDismissDirection.HORIZONTAL,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                            }
                          } catch (e) {
                            print('error in sending verification numbre');
                            print(e);
                          }
                        },
                        child: Text('verifiyNumber'.tr),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print('error in adding plastic card');
      print(e);
    }
  }

  static Future<PlaticCardTypeModel?> fetchMyPlasticCard() async {
    final token = MyPref.driverSecondToken;

    try {
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/card'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        var jsonString =
            PlaticCardTypeModel.fromJson(json.decode(response.body));
        return jsonString;
      } else {
        print('this is else statement in plastic card');
        print(response.statusCode);
      }
    } catch (e) {
      print('error in plastic card');

      print(e);
    }
  }

  static Future<IncomeModel?> myIncomeService(String incomeType) async {
    try {
      final token = MyPref.driverSecondToken;
      print('http://hamd.loko.uz/api/earn?sort=$incomeType');
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/earn?sort=$incomeType'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print('*********');
        print('success in my income ');
        print('*********');
        print(response.body);
        var jsonString = IncomeModel.fromJson(json.decode(response.body));
        return jsonString;
      } else {
        print('error in my income ');
        print(response.reasonPhrase);
      }
    } catch (e) {
      // print(response.statusCode);
      print('error in income service');
      print(e);
      wrongDialog();
    }
  }

  static Future finishOrder(int orderId) async {
    try {
      final token = MyPref.driverSecondToken;
      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/order/courier-finish'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: {
          'order_id': orderId.toString(),
        },
      );
      if (response.statusCode == 200) {
        print('success in finished order');
      } else {
        print('this is else statment');
        print(response.statusCode);
      }
    } catch (e) {
      // print(response.statusCode);
      print('error in driverleft');
      print(e);
      wrongDialog();
    }
  }

  static Future driverLeft(int orderId) async {
    try {
      final token = MyPref.driverSecondToken;
      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/order/courier-go'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: {
          'order_id': orderId.toString(),
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar(
          'driverOnWay'.tr,
          'driverOnWay'.tr,
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          borderRadius: 20,
          margin: const EdgeInsets.all(15),
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          isDismissible: true,
          // dismissDirection: SnackDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      }
    } catch (e) {
      print('error in driverleft');
      print(e);
      wrongDialog();
    }
  }

  static Future acceptOrder(BuildContext context, int orderId) async {
    final token = MyPref.driverSecondToken;
    try {
      var response = await client.post(
        Uri.parse('http://hamd.loko.uz/api/order/courier-accept'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
        body: {
          'order_id': orderId.toString(),
        },
      );

      if (response.statusCode == 200) {
        await AllServices.makeBill(orderId: orderId.toString());
        Provider.of<ScreenControllerProvider>(context, listen: false)
            .screenChanger(1);
        context.read<AllAcceptedOrdersProvider>().fetchAllAcceptedOrders();
        print('*********');
        print('success in accepting products');
        print('********* accepted order id is:');
        print(response.body);
      } else if (response.statusCode == 422) {
        Get.dialog(
          GestureDetector(
            onTap: () => Get.back(),
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(.1),
              body: Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    color: Colors.white,
                    width: double.infinity,
                    // height: 140.0,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            // GestureDetector(
                            //   onTap: () {
                            //     Get.back();
                            //   },
                            //   child: Container(
                            //     alignment:
                            //         Alignment.topRight,
                            //     child: Icon(
                            //       Icons.cancel,
                            //       color:
                            //           ColorPalate.mainColor,
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            Text('notEngoughMoney'.tr,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 30),
                          ],
                        ),
                        Positioned(
                          top: 15,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.cancel,
                                color: ColorPalatte.strongRedColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      Get.dialog(
        GestureDetector(
          onTap: () => Get.back(),
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(.1),
            body: Center(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  color: Colors.white,
                  width: double.infinity,
                  // height: 140.0,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.back();
                          //   },
                          //   child: Container(
                          //     alignment:
                          //         Alignment.topRight,
                          //     child: Icon(
                          //       Icons.cancel,
                          //       color:
                          //           ColorPalate.mainColor,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 20),
                          Text('someThingWentWrong'.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(height: 30),
                        ],
                      ),
                      Positioned(
                        top: 15,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.cancel,
                              color: ColorPalatte.strongRedColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      );

      print('error in chatch');
      print(e);
    }
  }

  static Future<CodeConfirmModel?> profileFetchService() async {
    final token = MyPref.driverSecondToken;
    try {
      var response = await client.get(
        Uri.parse(ApiUrl.profile),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );
      print(response.request);
      if (response.statusCode == 200) {
        var body = CodeConfirmModel.fromJson(json.decode(response.body));
        print('User Data: ${response.body}');
        return body;
      }
      return null;
    } catch (e) {
      print('error in profileFetch');
      print(e);
    }
  }

  static Future codeConfirmFunction({required String code}) async {
    final token = MyPref.driverToken;
    var response = await client.post(
      Uri.parse(ApiUrl.sendSmsCode),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      body: {
        'code': code,
      },
    );
    print('condirm code part');
    print(response.request);
    if (response.statusCode == 200) {
      var body = CodeConfirmModel.fromJson(json.decode(response.body));
      print('confrim token');
      print(response.body);
      MyPref.driverSecondToken = body.data!.token!;
      print('token after confirm');

      print('this isss secondToken');
      print(MyPref.driverSecondToken);
      print('my fcmToken is ');
      print(body.data!.deviceToken!);
      print(body.data!.phone);
      // pController.fetchProfileData();
      Get.offAll(MainOrdersScreen());
      return body;
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future signInUser(
      {required String userNumber, required String fcmToken}) async {
    try {
      var response = await client.post(Uri.parse(ApiUrl.signIn), body: {
        'phone': userNumber,
        'role': '4',
        'device_token': fcmToken,
      });
      if (response.statusCode == 200) {
        var body = SignInModel.fromJson(json.decode(response.body));
        print(response.body);
        print('bu yerda token');
        print(body.data!.token);

        print('bu yerda code');
        print(body.data!.code!.code);
        MyPref.driverToken = body.data!.token!;
        MyPref.driverCode = body.data!.code!.code!;
        MyPref.driverPhoneNumber = body.data!.code!.phone!;

        print('saved token');
        print(MyPref.driverToken);
        Get.back();
        Get.to(SmsScreen());
      }
      return;
    } catch (e) {
      print('error in catch');
      return print(e);
    }
  }

  static Future<AllOrdersModel> fetchAllOrdersProvider() async {
    final token = MyPref.driverSecondToken;

    var response = await client.get(
      Uri.parse('http://hamd.loko.uz/api/order/courier-list'),
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('fetching all orders success with provide');
      var jsonString = AllOrdersModel.fromJson(json.decode(response.body));
      return jsonString;
    } else {
      print('failure fetching all orders success with provide');
      print(response.reasonPhrase);

      return AllOrdersModel(data: []);
    }
  }

  static Future<AllAcceptedOrderModel?> fetchAllAcceptedOrdersService() async {
    final token = MyPref.driverSecondToken;

    try {
      var response = await client.get(
        Uri.parse('http://hamd.loko.uz/api/order/courier-list-mine?status=1'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print('fetching all orders success with provide');
        var body = AllAcceptedOrderModel.fromJson(json.decode(response.body));
        return body;
      }
    } catch (e) {
      print('error in fetchAllACcepted');
      print(e);
    }
  }

  static Future<AllAcceptedOrderModel?> fetchAllMyOrder(
      String orderType) async {
    final token = MyPref.driverSecondToken;

    try {
      print('http://hamd.loko.uz/api/order/courier-list-mine?sort=$orderType');
      var response = await client.get(
        Uri.parse(
            'http://hamd.loko.uz/api/order/courier-list-mine?sort=$orderType'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print('fetching all my orders success with provide');
        var body = AllAcceptedOrderModel.fromJson(json.decode(response.body));
        return body;
      }
    } catch (e) {
      print('error in myoder');
      print(e);
    }
  }
}
