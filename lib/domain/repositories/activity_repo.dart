import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/domain/enums/activity_type.dart';
import 'package:hypertrip/domain/models/activity/activity.dart';
import 'package:hypertrip/domain/models/attachment/upload_attachment_response.dart';
import 'package:hypertrip/domain/repositories/attachment_repo.dart';
import 'package:hypertrip/exceptions/request_exception.dart';
import 'package:hypertrip/utils/currency_formatter.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

class ActivityRepo {
  final Dio apiClient = getIt.get<Dio>();
  final AttachmentRepo _attachmentRepo = getIt.get<AttachmentRepo>();

  ActivityRepo();

  Future<Activity> get(String id) async {
    try {
      final response = await apiClient.get('/activities/$id');

      return Activity.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw RequestException(msg_activity_not_found);
      }
      throw RequestException(msg_server_error);
    }
  }

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
          'items': items,
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
      throw RequestException(msg_save_activity_failed);
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
    required String? imagePath,
    required double amount,
    required int dayNo,
    required String note,
    required DateTime dateTime,
  }) async {
    try {
      /// Upload images
      UploadAttachmentResponse? uploadedImage;
      if (imagePath != null && imagePath.isNotEmpty) {
        uploadedImage = await _attachmentRepo.postAttachment(imagePath);

        if (uploadedImage == null) {
          throw RequestException(msg_upload_image_failed);
        }
      }

      var res = await apiClient.post('/activities', data: {
        'type': ActivityType.IncurredCost.name,
        'incurredCostActivity': {
          'tourGroupId': tourGroupId,
          'cost': amount,
          'currency': CurrencyName.vi,
          // ignore: dead_code
          'imageId': uploadedImage?.id,
          'title': '',
          'note': note,
          'dayNo': dayNo,
          'createdAt': dateTime.toIso8601String(),
        }
      });

      return res.data.toString();
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) {
        throw RequestException(msg_tour_group_not_found);
      }
      debugPrint(e.toString());
      throw RequestException(msg_server_error);
    }
  }

  //#endregion
}
