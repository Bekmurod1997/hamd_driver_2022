import 'package:flutter/material.dart';

class ProfileImageProvider extends ChangeNotifier {
  String? imageAvatar;
  String? drivingLicencePhoto;
  String? drivingPasswordPhoto;

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
}
