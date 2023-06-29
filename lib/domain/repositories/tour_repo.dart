import 'package:dio/dio.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/tour/tour.dart';
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

  Future<Tour?> getTourDetail(String? tourId) async {
    if (tourId == null) return null;

    try {
      var res = await apiClient.get('/tours/$tourId/details');

      return Tour.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 404) return null;

      throw Exception('Server error');
    }
  }
}
