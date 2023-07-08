import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/utils/dio.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;
void initialGetIt() {
  /// base
  getIt.registerLazySingleton<Dio>(() => apiClient);
  getIt.registerLazySingleton<Dio>(() => fourSquareApiClient,
      instanceName: 'publishApiClient');
  getIt.registerLazySingleton(() => Logger());

  /// repositories
  getIt.registerLazySingleton(() => UserRepo());
  getIt.registerLazySingleton(() => GroupRepo());
  getIt.registerLazySingleton(() => FoursquareRepo());
  getIt.registerLazySingleton(() => TourRepo());
}
