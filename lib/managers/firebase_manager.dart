import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/features/public/account/parts/emergency_bottomsheet.dart';
import 'package:hypertrip/firebase_options.dart';
import 'package:hypertrip/managers/firebase_messaging_manager.dart';

final getIt = GetIt.instance;

Future<void> registerManager() async {
  await Firebase.initializeApp(
    options: Platform.isIOS
        ? DefaultFirebaseOptions.ios
        : DefaultFirebaseOptions.android,
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

  getIt.registerFactory(() =>
      FirebaseMessagingManager(getIt<NotificationRepo>())..setupFirebaseFCM());
  getIt.registerFactory(() => FirestoreRepository());

  getIt.registerFactory(() => LocationManager());
}
