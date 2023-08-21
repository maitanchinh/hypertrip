import 'package:dio/dio.dart';
import 'package:hypertrip/domain/models/tour_guide/assigned_tour.dart';
import '../../utils/get_it.dart';

class TourGuideRepo {
  final Dio apiClient = getIt.get<Dio>();

  TourGuideRepo();

  Future<List<AssignedTour>> getAssignedTour(String tourGuideId) async {
    try {
      var res = await apiClient.get('/tour-guides/$tourGuideId/assigned-groups');
      return AssignedTour.fromJsonList(res.data);
    } on DioException catch (e) {
      throw Exception('Server error');
    }

  }
}