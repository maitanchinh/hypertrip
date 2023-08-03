// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/models/incidents/warning_argument.dart';
import 'package:hypertrip/domain/models/incidents/weather_alert.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast_day.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/features/loading/view.dart';
import 'package:hypertrip/features/login_by_email/view.dart';
import 'package:hypertrip/features/login_by_phone/view.dart';
import 'package:hypertrip/features/public/alert_detail/alert_detail.dart';
import 'package:hypertrip/features/public/chat_detail/chat_detail_page.dart';
import 'package:hypertrip/features/public/edit_profile/edit_profile_screen.dart';
import 'package:hypertrip/features/public/nearby/view.dart';
import 'package:hypertrip/features/public/notification/notifcation_screen.dart';
import 'package:hypertrip/features/public/page.dart' as Public;
import 'package:hypertrip/features/public/warning_incident/warning_incident_page.dart';
import 'package:hypertrip/features/public/weather_detail/weather_detail_page.dart';
import 'package:hypertrip/features/root/view.dart';
import 'package:hypertrip/features/tour_guide/page.dart' as TourGuide;
import 'package:hypertrip/features/traveler/page.dart' as Traveler;
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
    case WeatherDetailPage.routeName:
      var arguments = settings.arguments;
      List<WeatherForecastDay> forecastDay =
          (arguments as WeatherResponse).forecast.forecastDay;
      String title = arguments.location.name;
      return MaterialPageRoute(
          builder: (_) =>
              WeatherDetailPage(forecastDay: forecastDay, title: title));
    case EditProfileScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => EditProfileScreen(settings.arguments as UserProfile));
    case NotificationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const NotificationScreen());
    case ChatDetailPage.routeName:
      return MaterialPageRoute(
          builder: (_) => ChatDetailPage(
              assignGroupResponse: settings.arguments as AssignGroupResponse));
    case WarningIncidentPage.routeName:
      return MaterialPageRoute(
          builder: (_) => WarningIncidentPage(
                args: settings.arguments as WarningArgument,
              ));
    case AlertDetail.routeName:
      return MaterialPageRoute(
          builder: (_) =>
              AlertDetail(alert: settings.arguments as WeatherAlert));

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
    case Public.NearbyMap.routeName:
      final arguments = settings.arguments as NearbyMap;
      return MaterialPageRoute(
          builder: (_) => Public.NearbyMap(
                places: arguments.places,
              ));
    // case Public.NearbyPage.routeName:
    //   return MaterialPageRoute(builder: (_) => const Public.NearbyPage());

    /// Tour guide
    case TourGuide.IncurredCostsActivity.routeName:
      return MaterialPageRoute(
          builder: (_) => const TourGuide.IncurredCostsActivity());

    /// Traveler
    case Traveler.Attendance.routeName:
      return MaterialPageRoute(builder: (_) => const Traveler.Attendance());

    default:
      return null;
  }
}
