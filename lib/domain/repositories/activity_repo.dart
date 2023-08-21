import 'package:dio/dio.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/activity/activity.dart';
import 'package:hypertrip/exceptions/request_exception.dart';
import 'package:hypertrip/utils/currency_formatter.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

class ActivityRepo {
  final Dio apiClient = getIt.get<Dio>();

  ActivityRepo();

  //#region AttendanceActivity

  Future<List<Activity>> getActivities(String tourGroupId) async {
    try {
      final response =
          await apiClient.get('/tour-groups/$tourGroupId/activities');

      return Activity.fromJsonList(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw RequestException(msg_tour_group_not_found);
      }
      throw RequestException(msg_server_error);
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
        throw RequestException(msg_tour_group_not_found);
      }
      throw RequestException(msg_server_error);
    }
  }

  Future<void> patchUpdate(Map<String, dynamic> payload) async {
    try {
      await apiClient.patch('/activities', data: payload);
    } on DioException catch (e) {
      throw RequestException(msg_save_attendance_activity_failed);
    }
  }

  Future<void> attend(String code) async {
    try {
      await apiClient.post('/activities/attend/$code');
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw RequestException(msg_attendance_invalid_code);
      } else {
        throw RequestException(msg_server_error);
      }
    }
  }

  //#endregion

  //#region IncurredCostsActivity
  Future<String> createNewIncurredCostsActivity({
    required String tourGroupId,
    required List<String> imagePaths,
    required int amount,
    required int dayNo,
    required String note,
  }) async {
    try {
      //todo upload images

      var res = await apiClient.post('/activities', data: {
        'type': ActivityType.IncurredCosts.name,
        'incurredCostActivity': {
          'tourGroupId': tourGroupId,
          'cost': amount,
          'currency': CurrencyName.vi,
          'title': '',
          'note': note,
          'dayNo': dayNo,
        }
      });

      return res.data.toString();
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw RequestException(msg_tour_group_not_found);
      }
      throw RequestException(msg_server_error);
    }
  }

  //#endregion
}
