// import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/root/view.dart';
import 'package:hypertrip/route/route.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/bloc_provider.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/system_config.dart';
import 'package:nb_utils/nb_utils.dart';

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
    // AppSettings.openAppSettings(type: AppSettingsType.wifi);

    return MultiBlocProvider(
      providers: multiBlocProvider(),
      child: MaterialApp(
        builder: EasyLoading.init(),
        theme: themeData(context),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        title: AppConstant.APP_NAME,
        initialRoute: initialRoute,
      ),
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

  /// Initial System config
  await SystemConfig.initialize();

  /// Run app
  runApp(App(initialRoute: initialRoute));
}

Future<String> _fetchProfileAndReturnInitialRoute() async {
  final UserRepo userRepo = getIt.get<UserRepo>();


  String initialRoute = '';
  try {
    var token = getStringAsync(AppConstant.TOKEN_KEY);
    print("_fetchProfileAndReturnInitialRoute $token");
    if (token.isNotEmpty) {
      await userRepo.getProfile();
      initialRoute = RootPage.routeName;
    }
    else{
      initialRoute = LoginByEmailPage.routeName;
    }
  } catch (ex) {
    debugPrint("ex ${ex.toString()}");
  }

  return initialRoute;
}
