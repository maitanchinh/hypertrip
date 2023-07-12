import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hypertrip/domain/models/notification/firebase_message.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class FirebaseMessagingManager {
  final NotificationRepo _notificationRepo;

  FirebaseMessagingManager(this._notificationRepo);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? _latestProcessedInitialMessageId;

  setupFirebaseFCM() async {
    initNotificationsSettings();

    // Push Notification arrives when the App is in Opened and in Foreground
    FirebaseMessaging.onMessage.listen((message) {
      _handleForegroundNotification(message);
    });

    // Push Notification is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationActionFromRemoteMessage(message);
    });
  }

  Future<void> initNotificationsSettings() async {
    // Config FirebaseMessaging Plugin - Used for iOS
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    _initLocalNotify();
  }

  void _initLocalNotify() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("onDidReceiveNotificationResponse ${details}");
      },
    );

    // Xử lý trường hợp ứng dụng được mở thông qua một thông báo
    _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails()
        .then((NotificationAppLaunchDetails? details) {
      if (details != null && details.didNotificationLaunchApp) {
        String? payload = details.notificationResponse?.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
          // Thực hiện các hành động khi người dùng nhấn vào thông báo tại đây.
          // Abcd
          print("_flutterLocalNotificationsPlugin click");
        }
      }
    });
  }

  Future<void> showNotification(String title, String body) async {
    if (title.isEmpty && body.isEmpty) return;
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high, showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics,
        payload: 'item x');
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> _handleForegroundNotification(RemoteMessage message) async {
    // Xử lý khi app đang được bật
    // Update unread count
    _handleNotificationActionFromRemoteMessage(message);

    showNotification(message.notification?.title ?? '', message.notification?.body ?? '');

    setValue(AppConstant.keyUnReadChat, true);

    final value = getIntAsync(AppConstant.keyCountNotify);
    setValue(AppConstant.keyCountNotify, value + 1);
  }

  /// When the user taps on a Notification with the Application close we have
  /// to consume it ones the App is completely started.
  void processInitialMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (_latestProcessedInitialMessageId == null ||
            _latestProcessedInitialMessageId != message.messageId) {
          debugPrint('Processing Initial Message');
          _latestProcessedInitialMessageId = message.messageId;
          _handleNotificationActionFromRemoteMessage(message);
        } else {
          debugPrint('Initial Message Already Processed');
        }
      }
    });
  }

  void _handleNotificationActionFromRemoteMessage(RemoteMessage message) {
    debugPrint('NEW NOTIFICATION _handleNotificationActionFromRemoteMessage ${message.toString()}');
    _handleNotificationAction(FirebaseMessage.fromJson(message.data));
  }

  void _handleNotificationAction(FirebaseMessage notificationMessage) {
    debugPrint('NEW NOTIFICATION ${notificationMessage.toString()}');

    performNotificationAction(notificationMessage);
  }

  void performNotificationAction(FirebaseMessage messageNotify) {}

  Future<void> deleteToken() => _firebaseMessaging.deleteToken();

  Future<String?> getNotificationToken() => _firebaseMessaging.getToken();

  /// Register Firebase Token to Server
  void registerTokenFCM(String uID) async {
    await _firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    getNotificationToken().then((firebaseToken) async {
      String? firebaseTokenLocal = getStringAsync(AppConstant.keyFcmToken);
      if (firebaseToken != null) {
        if (firebaseTokenLocal.isEmpty || firebaseTokenLocal != firebaseToken) {
          await setValue(AppConstant.keyFcmToken, firebaseToken);
          _notificationRepo.addTokenFCMApi(firebaseToken, uID).then((value) {});
        }
        print("firebase Token: $firebaseToken");
      }
    });
  }

  /// Remove Firebase Token to Server
  Future<void> clearToken() async {
    var fcmToken = await getNotificationToken();
    if (fcmToken != null) {
      deleteToken();
      await setValue(AppConstant.keyFcmToken, '');
      await _notificationRepo.deleteTokenFCMApi(fcmToken);
    }
  }

  Future<void> sendFCMNotifications(List<String> deviceTokens, String title, String body) async {
    final String tokenLocal = getStringAsync(AppConstant.keyFcmToken);
    deviceTokens.remove(tokenLocal);
    try {
      for (String token in deviceTokens) {
        final message = {
          "title": title,
          "body": body,
          "mutable_content": true,
          "sound": "Tri-tone"
        };
        final data = {};

        _notificationRepo.sendNotify(token, message, data);
      }

      print('Thông báo FCM đã được gửi thành công');
    } catch (error) {
      print('Lỗi khi gửi thông báo FCM: $error');
    }
  }
}
