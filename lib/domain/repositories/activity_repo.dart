import 'package:dio/dio.dart';
import 'package:hypertrip/utils/get_it.dart';

class ActivityRepo {
  final Dio apiClient = getIt.get<Dio>();

  ActivityRepo();


}