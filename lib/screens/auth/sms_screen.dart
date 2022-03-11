import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/screens/main_orders/main_orders_screen.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:hamd_driver/splash_screen.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({Key? key}) : super(key: key);

  @override
  _SmsScreenState createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final phoneNumber = MyPref.driverPhoneNumber;

  GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  int _start = 30;
  String errorMessage = '';
  void validateAndSave() async {
    final FormState? form = _formKey2.currentState;
    if (form!.validate()) {
      if (codeController.text == MyPref.driverCode) {
        AllServices.codeConfirmFunction(code: codeController.text);

        // Get.to(() => SplashScreen());
      } else {
        print('hatolik');
      }
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  _showSnackBar(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: ColorPalatte.mainPageColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Container(
              height: 320,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      width: 77,
                      height: 77,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: SvgPicture.asset('assets/icons/check.svg'),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Спасибо!',
                        style: FontStyles.boldStyle(
                          fontSize: 22,
                          fontFamily: 'Ubuntu',
                          color: Color(0xff232323),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Вы успешно авторизовались в системе доставки продукции лучшего фастфуда Самарканда!',
                        style: FontStyles.regularStyle(
                          fontSize: 16,
                          fontFamily: 'Ubuntu',
                          color: Color(0xff646974),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 54,
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 0,
                        color: ColorPalatte.strongRedColor,
                        onPressed: () => Get.to(() => MainOrdersScreen()),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'ОК',
                          style: FontStyles.boldStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalatte.mainPageColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 330,
              height: MediaQuery.of(context).size.height * .35,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color(0xff9F111B),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .12,
                  vertical: MediaQuery.of(context).size.height * .12,
                ),
                child: Image.asset(
                  'assets/images/logo-back.png',
                ),
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 4,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(61),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'newUser'.tr,
                          style: FontStyles.semiBoldStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            color: Color(0xff232323),
                          ),
                        ),
                        Text(
                          'enterCode'.tr,
                          style: FontStyles.boldStyle(
                            fontSize: 18,
                            fontFamily: 'Ubuntu',
                            color: Color(0xff232323),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: _formKey2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(15)),
                        height: 55.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.call,
                                color: Colors.grey,
                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: codeController,
                                // autofocus: true,
                                keyboardType: TextInputType.number,

                                //inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 15.0),
                                  hintText: 'enterCodeHint'.tr,
                                  hintStyle: FontStyles.regularStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Color(0xff9E9E9E),
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                validator: (value) {
                                  if (value == '') {
                                    setState(() {
                                      errorMessage = 'fieldCannotBeEmpty'.tr;
                                    });
                                    return '';
                                  } else if (value!.length < 6) {
                                    setState(() {
                                      errorMessage = 'fieldCannotBeLess6'.tr;
                                    });
                                    return '';
                                  } else if (value != MyPref.driverCode) {
                                    setState(() {
                                      errorMessage =
                                          'pleaseEnterCorrectCode'.tr;
                                    });
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                    ),
                    child: Column(
                      children: [
                        Text(
                          errorMessage,
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorPalatte.strongRedColor,
                          ),
                        ),
                        errorMessage.isEmpty
                            ? Container()
                            : SizedBox(
                                height: 10,
                              ),
                        Center(
                            child: _start == 0
                                ? GestureDetector(
                                    onTap: () {
                                      if (_start == 0) {
                                        setState(() {
                                          _start = 30;
                                        });
                                        startTimer();
                                        AllServices.signInUser(
                                            userNumber:
                                                MyPref.driverPhoneNumber,
                                            fcmToken: MyPref.fcmToken);
                                      } else {
                                        // _showSnackBar(context);
                                        validateAndSave();
                                      }
                                    },
                                    child: Text('sendCode'.tr))
                                : RichText(
                                    text: TextSpan(
                                      text: 'newCode'.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                            text: '$_start',
                                            style: TextStyle(
                                                color: ColorPalatte
                                                    .strongRedColor)),
                                        TextSpan(
                                          text: ' ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'sekund'.tr,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))

                        // Text('newCode'.tr + '$_start' + 'sekund'.tr)),
                      ],
                    ),
                    // child:
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .07),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 54,
                      width: double.infinity,
                      child: RaisedButton(
                        elevation: 0,
                        color: ColorPalatte.strongRedColor,
                        onPressed: () async {
                          if (MyPref.driverSecondToken != null) {
                            // await allOrdersController.fetchAllOrders();
                            print('Orders fetched');
                          }

                          // _showSnackBar(context);
                          validateAndSave();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'auth'.tr,
                          style: FontStyles.boldStyle(
                              fontSize: 16,
                              fontFamily: 'Ubuntu',
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
