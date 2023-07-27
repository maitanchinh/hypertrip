import 'package:dio/dio.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/activity/activity.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

class ActivityRepo {
  final Dio apiClient = getIt.get<Dio>();

  ActivityRepo();

  Future<List<Activity>> getActivities(String tourGroupId) async {
    try {
      final response =
          await apiClient.get('/tour-groups/$tourGroupId/activities');

      return Activity.fromJsonList(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception(msg_tour_group_not_found);
      }
      throw Exception(msg_server_error);
    }
  }

  Future<void> removeDraft(String id) {
    return apiClient.delete('/activities/draft/$id');
  }

  Future<String> createNewAttendance({
    required String tourGroupId,
    required int dayNo,
    String title = '',
    String note = '',
    List<String> items = const [],
  }) async {
    try {
      var res = await apiClient.post('/activities', data: {
        'type': ActivityType.Attendance.name,
        'attendanceActivity': {
          'tourGroupId': tourGroupId,
          'title': title,
          'note': note,
          'dayNo': dayNo,
          'items': items
        }
      });

      return res.data.toString();
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw Exception(msg_tour_group_not_found);
      }
      throw Exception(msg_server_error);
    }
  }

  Future<void> patchUpdate(Map<String, dynamic> payload) async {
    try {
      await apiClient.patch('/activities', data: payload);
    } on DioException catch (e) {
      throw Exception(msg_save_attendance_activity_failed);
    }
  }
}
