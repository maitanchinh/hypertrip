import 'package:dio/dio.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/tour/tour_detail.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/utils/get_it.dart';

class TourRepo {
  final Dio apiClient = getIt.get<Dio>();

  TourRepo();

  Future<List<Slot>> getSchedule(String? tourId) async {
    if (tourId == null) return [];

    try {
      var res = await apiClient.get('/tours/$tourId/schedules');

      return Slot.fromJsonList(res.data);
    } on DioException catch (e) {
      throw Exception('Server error');
    }
  }

  Future<TourDetail?> getTourDetail(String? tourId) async {
    if (tourId == null) return null;

    try {
      var res = await apiClient.get('/tours/$tourId/details');
      return TourDetail.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) return null;

      throw Exception('Server error');
    }
  }

  Future<UserProfile?> updateContacts(String id, List<String> contacts) async {
    try {
      final data = {
        "firstContactNumber": contacts[0],
        "secondContactNumber": contacts.length > 1 ? contacts[1] : ''
      };

      final response =
          await apiClient.put('/tour-guides/$id/contacts', data: data);
      final profile = UserProfile.fromJson(response.data);

      return profile;
    } catch (ex) {
      return null;
    }
  }

  Future<List<AssignGroupResponse>> getAllAssignedGroups(String id) async {
    try {
      final response = await apiClient.get('/tour-guides/$id/assigned-groups');

      return (response.data as List<dynamic>)
          .map((assignGroup) => AssignGroupResponse.fromJson(assignGroup))
          .toList();
    } catch (ex) {
      return [];
    }
  }

  Future<List<UserProfile>> getMembersTourGroup(String tourGuideId) async {
    try {
      final response = await apiClient.get('/tour-groups/$tourGuideId/members');
      return response.data != null
          ? (response.data as List<dynamic>)
              .map((profile) => UserProfile.fromJson(profile))
              .toList()
          : [];
    } catch (ex) {
      return [];
    }
  }

  Future<List<String>> getAllTokenFCMDeviceGroup(List<String> userIds) async {
    try {
      // final body = json.encode(userIds);
      final response =
          await apiClient.post('/fcm-tokens/find-by-users', data: userIds);
      return response.data != null
          ? (response.data as List<dynamic>)
              .map((res) => res['token'] as String)
              .toList()
          : [];
    } catch (ex) {
      return [];
    }
  }
}
