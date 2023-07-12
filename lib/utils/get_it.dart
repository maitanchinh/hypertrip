import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/domain/repositories/warning_incident_repository.dart';
import 'package:hypertrip/managers/firebase_messaging_manager.dart';
import 'package:hypertrip/utils/dio.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

void initialGetIt() {
  /// base
  getIt.registerLazySingleton<Dio>(() => apiClient);
  getIt.registerLazySingleton<Dio>(() => fourSquareApiClient, instanceName: 'publishApiClient');
  getIt.registerLazySingleton(() => Logger());

  /// repositories
  getIt.registerLazySingleton(() => UserRepo());
  getIt.registerLazySingleton(() => GroupRepo());
  getIt.registerLazySingleton(() => FoursquareRepo());
  getIt.registerLazySingleton(() => TourRepo());

  getIt.registerLazySingleton(() => NotificationRepo(getIt<Dio>()));
  getIt.registerLazySingleton(() => WarningIncidentRepository());
  _registerManager();
}

void _registerManager() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAPZiYIlR-ztOa6maus6urUhs1Z-6spyj4",
      appId: "1:712635131057:android:7b999176bb6fe22101ae90",
      messagingSenderId: "712635131057",
      projectId: "travel-378415",
    ),
  );

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // Setup firebase listener for permission changes
  firebaseAuth.authStateChanges().listen((user) async {
    if (user == null) {
      try {
        final UserCredential user = await firebaseAuth.signInAnonymously();
        final User? currentUser = firebaseAuth.currentUser;

        assert(user.user?.uid == currentUser?.uid);
      } catch (error, stacktrace) {}
    } else {}
  });

  getIt.registerFactory(
      () => FirebaseMessagingManager(getIt<NotificationRepo>())..setupFirebaseFCM());
  getIt.registerFactory(() => FirestoreRepository());
}
