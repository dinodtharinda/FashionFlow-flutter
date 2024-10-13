import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    if(fCMToken != null){
      return fCMToken;
    }
    return 'token null';
  }

  Future<void> disposeNotifications() async {
    // await _firebaseMessaging.deleteToken();
  }
}
