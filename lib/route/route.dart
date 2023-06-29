// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:hypertrip/features/public/page.dart' as Public;

PageRoute? generateRoute(RouteSettings settings) {
  print(settings.arguments);

  switch (settings.name) {
    /// Authentication
    // case LoginByEmailPage.routeName:
    //   return MaterialPageRoute(builder: (_) => const LoginByEmailPage());
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
