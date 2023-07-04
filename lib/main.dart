import 'package:flutter/material.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/root/view.dart';
import 'package:hypertrip/route/route.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Show native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  _initialApp();

  /// Remove native splash screen
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  final String initialRoute;
  final UserRepo userRepo = getIt.get<UserRepo>();

  App({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      title: "Hyper Trip",
      initialRoute: initialRoute,
    );
  }
}

Future<void> _initialApp() async {
  /// Initial nb_utils lib
  await initialize();

  /// Initial get_it lib
  initialGetIt();

  /// Fetch Profile
  var initialRoute = await _fetchProfileAndReturnInitialRoute();

  /// Run app
  runApp(App(initialRoute: initialRoute));
}

Future<String> _fetchProfileAndReturnInitialRoute() async {
  final UserRepo userRepo = getIt.get<UserRepo>();
  var initialRoute = RootPage.routeName;

  try {
    await userRepo.getProfile();
  } catch (e) {
    initialRoute = LoginByEmailPage.routeName;
  }

  return initialRoute;
}