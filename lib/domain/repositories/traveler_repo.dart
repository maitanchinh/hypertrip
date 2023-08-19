import 'package:dio/dio.dart';


import '../../utils/get_it.dart';
import '../models/traveler/joined_tour.dart';

class TravelerRepo {
  final Dio apiClient = getIt.get<Dio>();

  TravelerRepo();

  Future<List<JoinedTour>> getJoinedTour(String travelerId) async {
    try {
      var res = await apiClient.get('/travelers/$travelerId/joined-groups');
      return JoinedTour.fromJsonList(res.data);
    } on DioException catch (e) {
      throw Exception('Server error');
    }

  }
  
}