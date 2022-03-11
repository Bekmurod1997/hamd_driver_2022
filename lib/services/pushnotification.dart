import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hamd_driver/constants/sp_keys/my_prefs.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;

  static Future initializeApp() async {
    await Firebase.initializeApp();

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    token = await FirebaseMessaging.instance.getToken();
    MyPref.fcmToken = token!;

    print('firebase toke: $token');

    FirebaseMessaging.onBackgroundMessage(_onBackgoundHandler);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenandler);
  }

  static Future _onBackgoundHandler(RemoteMessage message) async {
    print("${message.data['title']}");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print("${message.messageId}");
  }

  static Future _onMessageOpenandler(RemoteMessage message) async {
    print("${message.messageId}");
  }
}
