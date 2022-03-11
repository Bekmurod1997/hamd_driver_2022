import 'package:get_storage/get_storage.dart';
import 'package:hamd_driver/constants/sp_keys/shared_preferances.dart';

class MyPref {
  static final prefs = GetStorage();

  static String get driverToken => prefs.read(SPKeys.driverToken) ?? '';
  static String get driverCode => prefs.read(SPKeys.driverCode) ?? '';
  static String get driverSecondToken =>
      prefs.read(SPKeys.driverSecondToken) ?? '';
  static String get driverPhoneNumber =>
      prefs.read(SPKeys.driverPhoneNumber) ?? '';
  static String get driverFToken => prefs.read(SPKeys.driverFToken) ?? '';
  static String get driverLang => prefs.read(SPKeys.dirverLang) ?? '';
  static String get fcmToken => prefs.read(SPKeys.fcmToken) ?? '';
  static String get plasticCardId => prefs.read(SPKeys.plasticCardId) ?? '';

  static set fcmToken(String value) => prefs.write(SPKeys.fcmToken, value);
  static set plasticCardId(String value) =>
      prefs.write(SPKeys.plasticCardId, value);
  static set driverToken(String value) =>
      prefs.write(SPKeys.driverToken, value);
  static set driverCode(String codeValue) =>
      prefs.write(SPKeys.driverCode, codeValue);
  static set driverFToken(String fToken) =>
      prefs.write(SPKeys.driverFToken, fToken);
  static set driverPhoneNumber(String phoneNumber) =>
      prefs.write(SPKeys.driverPhoneNumber, phoneNumber);
  static set driverSecondToken(String secondTokenvalue) =>
      prefs.write(SPKeys.driverSecondToken, secondTokenvalue);
  static set driverLang(String lang) => prefs.write(SPKeys.dirverLang, lang);

  static clearToken() => prefs.remove(SPKeys.driverToken);
  static clearSecondToken() => prefs.remove(SPKeys.driverSecondToken);
  static clearCode() => prefs.remove(SPKeys.driverCode);
  static clearPhoneNumber() => prefs.remove(SPKeys.driverPhoneNumber);
  static clearFToken() => prefs.remove(SPKeys.driverFToken);
  static clearLang() => prefs.remove(SPKeys.dirverLang);

  static allTokentsClear() {
    prefs.remove(SPKeys.driverToken);
    prefs.remove(SPKeys.plasticCardId);
    prefs.remove(SPKeys.driverSecondToken);
    prefs.remove(SPKeys.driverFToken);
    prefs.remove(SPKeys.driverPhoneNumber);
    prefs.remove(SPKeys.fcmToken);
  }
}
