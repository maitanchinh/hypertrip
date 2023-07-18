// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:hypertrip/features/loading/view.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/login_by_phone/view.dart';
import 'package:hypertrip/features/public/page.dart' as Public;
import 'package:hypertrip/features/root/view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

PageRoute? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    /// Root
    case RootPage.routeName:
      return MaterialWithModalsPageRoute(builder: (_) => const RootPage());
    case LoadingPage.routeName:
      return MaterialPageRoute(builder: (_) => const LoadingPage());

    /// Authentication
    case LoginByEmailPage.routeName:
      return MaterialPageRoute(builder: (_) => const LoginByEmailPage());
    case LoginByPhonePage.routeName:
      return MaterialPageRoute(builder: (_) => const LoginByPhonePage());

    // case LoginByPhonePage.routeName:
    //   // test animation page transition
    //   return PageTransition(
    //       child: const LoginByPhonePage(),
    //       type: PageTransitionType.rightToLeftWithFade,
    //       settings: settings,
    //       childCurrent: const LoginByEmailPage(),
    //       duration: const Duration(milliseconds: 600),
    //       isIos: true);

    /// Public
    case Public.CurrentTourPage.routeName:
      return MaterialPageRoute(builder: (_) => const Public.CurrentTourPage());
    case Public.TourDetailPage.routeName:
      return MaterialPageRoute(
          builder: (_) => Public.TourDetailPage(
              tourId: (settings.arguments as Map)['tourId'].toString()));
    // case Public.NearbyPage.routeName:
    //   return MaterialPageRoute(builder: (_) => const Public.NearbyPage());

    /// Tour guide

    /// Traveler

    default:
      return null;
  }
}
