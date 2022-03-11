import 'package:flutter/material.dart';
import 'package:hamd_driver/services/all_services.dart';
import 'package:hamd_driver/models/code_confirm_model.dart';

class ProfileFetchProvider extends ChangeNotifier {
  Datam? userInfo;
  bool isLoading = true;
  String? imageAvatar;
  String? drivingLicencePhoto;
  String? drivingPasswordPhoto;
  String? userName;
  double sendImagesProgress = 0.0;

  void changeSendImagesProgress(double per) {
    sendImagesProgress = per;
    notifyListeners();
  }

  void userNameChanger(BuildContext context, String? name) {
    userName = name;
    print('userNameChange $userName');
    notifyListeners();
  }

  void imageAvatarChanger(BuildContext context, String? image) {
    imageAvatar = image;
    print(imageAvatar);
    notifyListeners();
  }

  void drivingLicencePhotoChanger(BuildContext context, String? image) {
    drivingLicencePhoto = image;
    print(drivingLicencePhoto);
    notifyListeners();
  }

  void drivingPasswordPhotoChanger(BuildContext context, String? image) {
    drivingPasswordPhoto = image;
    print(drivingPasswordPhoto);
    notifyListeners();
  }

  void fetchUserInfo() async {
    try {
      var response = await AllServices.profileFetchService();
      userInfo = response?.data;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
