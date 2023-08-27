import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/domain/repositories/attachment_repo.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/domain/repositories/tour_guide_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/traveler_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/domain/repositories/warning_incident_repository.dart';
import 'package:hypertrip/features/public/current_tour/cubit.dart';
import 'package:hypertrip/managers/firebase_manager.dart';
import 'package:hypertrip/utils/dio.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

Future<void> initialGetIt() async{
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
  getIt.registerLazySingleton(() => ActivityRepo());
  getIt.registerLazySingleton(() => TravelerRepo());
  getIt.registerLazySingleton(() => TourGuideRepo());
  getIt.registerLazySingleton(() => AttachmentRepo());

  getIt.registerLazySingleton(() => NotificationRepo());
  getIt.registerLazySingleton(() => WarningIncidentRepository());
  await registerManager();

  getIt.registerFactory(() => CurrentTourCubit());
}
