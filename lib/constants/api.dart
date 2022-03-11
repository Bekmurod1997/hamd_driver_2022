abstract class ApiUrl {
  static const http = 'http://';
  static const baseUrl = 'hamd.loko.uz';
  static const apiUrl = '${http + baseUrl}/api/';

  // Authenticate

  static const user = '${apiUrl}user/';

  static const signIn = '${user}sign-in';
  static const sendSmsCode = '${user}send-sms-code';
  static const logOut = '${user}log-out';

  //Driver

  static const profile = '${user}profile';
  static const updateProfile = '${user}update';
  static const acceptOrder = 'http://hamd.loko.uz/api/order/courier-accept';
}
