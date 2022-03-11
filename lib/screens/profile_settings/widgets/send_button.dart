import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:hamd_driver/constants/api.dart';

import 'package:hamd_driver/constants/colors.dart';
import 'package:hamd_driver/constants/fonts.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';
import 'package:hamd_driver/providers/profile_fetch_provider.dart';
import 'package:provider/provider.dart';

class SendButton extends StatefulWidget {
  final String? userName;
  final File? userImage;
  final File? drivingPassport;
  final File? drivingLicence;
  const SendButton({
    Key? key,
    required this.userImage,
    required this.userName,
    required this.drivingPassport,
    required this.drivingLicence,
  }) : super(key: key);

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
      child: Container(
        height: 54,
        width: double.infinity,
        child: RaisedButton(
          elevation: 0,
          color: ColorPalatte.strongRedColor,
          onPressed: () async {
            if (isEdited == false) {
              print('pressing edit');
              setState(() {
                isEdited = true;
              });
              try {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 8, left: 8),
                            child: Consumer<ProfileFetchProvider>(
                              builder: (context, info, child) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 30),
                                    Text(
                                      'pleaseWait'.tr,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    });
                FormData formData = FormData.fromMap({
                  'name': widget.userName,
                  // 'phone': phoneController.text,
                });
                if (widget.userImage != null) {
                  String fileName = widget.userImage!.path.split('/').last;
                  formData.files.addAll([
                    MapEntry(
                      "photo",
                      await MultipartFile.fromFile(
                        widget.userImage!.path,
                        filename: fileName,
                      ),
                    ),
                  ]);
                }

                if (widget.drivingPassport != null) {
                  String fileName =
                      widget.drivingPassport!.path.split('/').last;
                  formData.files.addAll([
                    MapEntry(
                      "passport",
                      await MultipartFile.fromFile(
                        widget.drivingPassport!.path,
                        filename: fileName,
                      ),
                    ),
                  ]);
                }
                if (widget.drivingLicence != null) {
                  String fileName = widget.drivingLicence!.path.split('/').last;
                  formData.files.addAll([
                    MapEntry(
                      "driver_license",
                      await MultipartFile.fromFile(
                        widget.drivingLicence!.path,
                        filename: fileName,
                      ),
                    ),
                  ]);
                }

                final token = MyPref.driverSecondToken;
                var response = await dio.post(ApiUrl.updateProfile,
                    data: formData,
                    options: Options(
                      headers: {
                        HttpHeaders.authorizationHeader: 'Bearer $token'
                      },
                    ), onReceiveProgress: (int sent, int total) {
                  context
                      .read<ProfileFetchProvider>()
                      .changeSendImagesProgress((sent / total).round() * 100);
                });
                if (response.statusCode == 200) {
                  setState(() {
                    isEdited = false;
                  });
                  g.Get.back();
                  context.read<ProfileFetchProvider>().fetchUserInfo();
                  context
                      .read<ProfileFetchProvider>()
                      .changeSendImagesProgress(0);
                  g.Get.snackbar(
                    '',
                    '',
                    messageText: const Text(
                      'Ваши данные сохранены!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: const Color(0xff007E33),
                  );
                }
              } catch (e) {
                print('error in sending data');
                print(e);
              }
            } else {
              print('edited presssed already');
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Text(
            'saveChanges'.tr,
            style: FontStyles.boldStyle(
                fontSize: 16, fontFamily: 'Ubuntu', color: Colors.white),
          ),
        ),
      ),
    );
  }
}
