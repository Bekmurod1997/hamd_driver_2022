import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:get/get.dart';
import 'package:hamd_driver/masks/mask_format.dart';
import 'package:hamd_driver/screens/auth/sms_screen.dart';
import 'package:hamd_driver/services/all_services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String errorMessage = '';
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   print(MyPref.fcmToken);
    //   _firebaseMessaging.getNotificationSettings();
    //   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //       badge: true, alert: true, sound: true);
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;
    //     print('navvvvv');
    //     // print(message.notification!.title);
    //   });
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage messag) {});
  }

  void validateAndSave() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      //   Get.to(SmsScreen());
      print('Form is valid');
      Get.dialog(
        Scaffold(
          backgroundColor: Colors.black.withOpacity(.1),
          body: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              color: Colors.white,
              width: double.infinity,
              height: 100.0,
              child: Row(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        ColorPalatte.strongRedColor),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'pleaseWait'.tr,
                    style: FontStyles.lightStyle(
                      fontSize: 19,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      AllServices.signInUser(
          userNumber: smsController.text, fcmToken: MyPref.fcmToken);
    } else {
      print('Form is invalid');
    }
  }

  // _showSnackBar(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           insetPadding: EdgeInsets.zero,
  //           backgroundColor: Colors.white,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           content: Container(
  //             height: 200,
  //             width: MediaQuery.of(context).size.width * 0.75,
  //             child: Padding(
  //               padding: const EdgeInsets.only(
  //                   top: 20, bottom: 20, right: 8, left: 8),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Подтверждение!',
  //                     style: FontStyles.boldStyle(
  //                       fontSize: 22,
  //                       fontFamily: 'Ubuntu',
  //                       color: Color(0xff232323),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 18,
  //                   ),
  //                   RichText(
  //                     text: TextSpan(
  //                         text: 'Мы отправим вам проверочный код на номер ',
  //                         style: FontStyles.regularStyle(
  //                           fontSize: 16,
  //                           fontFamily: 'Ubuntu',
  //                           color: Color(0xff646974),
  //                         ),
  //                         children: [
  //                           TextSpan(
  //                             text: '+998 90 585 85 65',
  //                             style: FontStyles.boldStyle(
  //                                 fontSize: 20,
  //                                 fontFamily: 'Ubuntu',
  //                                 color: Color(0xff232323)),
  //                           )
  //                         ]),
  //                   ),
  //                   Spacer(),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                     children: [
  //                       SizedBox(
  //                         width: MediaQuery.of(context).size.width * .33,
  //                         height: 50,
  //                         child: RaisedButton(
  //                           elevation: 0,
  //                           color: Colors.white,
  //                           onPressed: () => Get.back(),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(15)),
  //                           child: Text(
  //                             'Отмена',
  //                             style: FontStyles.semiBoldStyle(
  //                                 fontSize: 14,
  //                                 fontFamily: 'Ubuntu',
  //                                 color: Colors.black),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 11,
  //                       ),
  //                       SizedBox(
  //                         width: MediaQuery.of(context).size.width * .33,
  //                         height: 50,
  //                         child: RaisedButton(
  //                           elevation: 0,
  //                           color: ColorPalatte.strongRedColor,
  //                           onPressed: () => Get.to(SmsScreen()),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(15)),
  //                           child: Text(
  //                             'Отправить',
  //                             style: FontStyles.semiBoldStyle(
  //                                 fontSize: 14,
  //                                 fontFamily: 'Ubuntu',
  //                                 color: Colors.white),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController smsController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorPalatte.mainPageColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  color: ColorPalatte.strongRedColor,
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
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(61),
                    child: Text('firstAuth'.tr,
                        style: FontStyles.boldStyle(
                          fontSize: 14,
                          fontFamily: 'Ubuntu',
                          color: Color(0xff232323),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                          const Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.phone_android,
                              color: Colors.grey,
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              inputFormatters: [InputMask.maskPhoneNumber],
                              controller: smsController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 15.0),
                                hintText: 'enterYourNumber'.tr,
                                hintStyle: FontStyles.regularStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Color(0xff9E9E9E)),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                              validator: (value) {
                                // print(value!.length);
                                if (value == '') {
                                  setState(() {
                                    errorMessage = 'fieldCannotBeEmpty'.tr;
                                  });
                                  return '';
                                } else if (value!.length < 17) {
                                  setState(() {
                                    errorMessage = 'fieldCannotBeLess'.tr;
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
                  errorMessage.isEmpty ? Container() : SizedBox(height: 10),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorPalatte.strongRedColor,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .07),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              content: SingleChildScrollView(
                                child: Container(
                                  // height: 440,
                                  width:
                                      MediaQuery.of(context).size.width * .75,
                                  child: Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.center,
                                        children: [
                                          Expanded(child: Container()),
                                          Expanded(
                                            flex: 6,
                                            child: Center(
                                              // color: Colors.red,
                                              child: Text(
                                                'dilogTitle'.tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: ColorPalatte
                                                        .strongRedColor,
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                      // Text(
                                      //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
                                      // Text(
                                      //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'buAuth'.tr,
                            style: FontStyles.regularStyle(
                                fontSize: 13,
                                fontFamily: 'Ubuntu',
                                color: Color(0xff858585)),
                            children: [
                              TextSpan(
                                text: 'condtionAndRules'.tr,
                                style: FontStyles.boldStyle(
                                    fontSize: 12,
                                    fontFamily: 'Ubuntu',
                                    color: Color(0xff858585)),
                              )
                            ]),
                      ),
                    ),
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
                        onPressed: validateAndSave,
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
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
