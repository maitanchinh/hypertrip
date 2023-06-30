import 'package:flutter/material.dart';
import 'package:hypertrip/features/public/current_tour/view.dart';
import 'package:hypertrip/features/root/view.dart';
import 'package:hypertrip/route/route.dart';
import 'package:hypertrip/theme/theme.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  // Initialize nb_utils
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  // Initialize get_it
  initialGetIt();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData(context),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        title: "Hyper Trip",
        // routes: routes,
        initialRoute: RootPage.routeName);
  }
}
