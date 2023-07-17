import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:hypertrip/domain/models/notification/firebase_message.dart';

class NotificationRepo {
  final Dio _apiClient;

  NotificationRepo(this._apiClient);

  /// Add token FCM
  Future<dynamic> addTokenFCMApi(String tokenFCM, String uID) async {
    final response =
        await _apiClient.post('/fcm-tokens', data: jsonEncode({'token': tokenFCM, 'userId': uID}));
    return response;
  }

  /// Delete token FCM
  Future<dynamic> deleteTokenFCMApi(String uID) async {
    final response = await _apiClient.post('/fcm-tokens/$uID');
    return response;
  }

  Future<dynamic> sendNotify(String token, Map message, Map data) async {
    final response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "key=AAAApexdJLE:APA91bFj-w9MNEliG1R4fPRVFcqvG3BPO6zc3y0l-yv-qiSz1Cw-oC6RevZmXN4pUwxWCNEShUgYReQeR3rRq4gF_R1BFZryueeOEWTKS349-HUh6oa9qCp9mXlU9b5xuPzWjsPaW8x3"
        },
        body: jsonEncode({"to": token, "notification": message, "data": data}));

    return response;
  }

  Future<List<FirebaseMessage>> fetchNotificationList() async {
    final response = await _apiClient.get('/notifications');
    return response.data != null
        ? response.data.map<FirebaseMessage>((json) => FirebaseMessage.fromJson(json)).toList()
        : [];
  }

  Future<dynamic> readNotification(String id) async {
    try {
      final response = await _apiClient.put('/notifications/$id/read');

      return response;
    } on DioException catch (e) {
      print('e ${e}');
    }
  }

  Future<dynamic> readAllNotifications() async {
    try {
      final response = await _apiClient.put('/notifications/read-all');

      return response;
    } on DioException catch (e) {
      print('e ${e}');
    }
  }

  Future<int> getCountNotify() async {
    try {
      final response = await _apiClient.get('/notifications/unread-count');

      return response.data['count'] ?? 0;
    } on DioException catch (e) {
      return 0;
    }
  }
}
