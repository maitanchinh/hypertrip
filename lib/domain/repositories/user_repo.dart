import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:nb_utils/nb_utils.dart';

class UserRepo {
  final Dio apiClient = getIt.get<Dio>();
  static UserProfile? profile;

  UserRepo();

  Future<void> login({required String username, required String password}) async {
    try {
      var res = await apiClient.post('/auth', data: {'username': username, 'password': password});

      var token = res.data['token'] as String?;

      if (token == null || token.isEmpty) {
        throw Exception(msg_login_token_invalid);
      }

      await setValue(AppConstant.TOKEN_KEY, token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception(msg_login_failed_title);
      }

      throw Exception(msg_server_error);
    }
  }

  Future<UserProfile> getProfile() async {
    try {
      var res = await apiClient.get('/users/self/profile');

      profile = UserProfile.fromJson(res.data);

      return profile!;
    } on DioException catch (_) {
      throw Exception(msg_server_error);
    }
  }

  Future<int> getTravelInfo(String id) async {
    try {
      final response = await apiClient.get('/users/$id/travel-info');
      return response.data['tourCount'];
    } catch (ex) {
      return 0;
    }
  }

  Future<dynamic> updatePassword(String newPass) async {
    try {
      final data = {'password': newPass};
      var res = await apiClient.put('/users/self/password', data: data);

      return res;
    } on DioException catch (e) {
      throw Exception(msg_server_error);
    }
  }

  Future<UserProfile?> updateInfo(
      String firstName, String lastName, String gender, String address, String urlAvatar) async {
    try {
      final formData = {
        "bankName": "",
        "bankNumber": "",
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "address": address,
        "avatarId": urlAvatar
      };

      var res = await apiClient.patch('/users/self/profile', data: formData);
      profile = UserProfile.fromJson(res.data);
      return profile;
    } on DioException catch (e) {
      return null;
    }
  }

  Future<dynamic> attachmentsFile(File? pathAvatar) async {
    try {
      if (pathAvatar == null) return null;

      FormData formData = FormData();
      formData.files.add(MapEntry('file', await MultipartFile.fromFile(pathAvatar.path)));

      var res = await apiClient.post('/attachments', data: formData);
      return res.data;
    } on DioException catch (e) {
      return null;
    }
  }

  
}
