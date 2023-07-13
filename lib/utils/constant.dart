// ignore_for_file: constant_identifier_names

import 'package:nb_utils/nb_utils.dart';

class AppConstant {
  /// Keys
  static const String TOKEN_KEY = 'token';
  static const String keyFcmToken = 'fcm_token';
  static const String keyUnReadChat = 'unread_chat';
  static const String keyCountNotify = 'count_notify';

  /// Values
  static const String APP_NAME = 'Hyper Trip';

  /// Hosts
  static const String API_URL = 'https://c105-27-77-240-60.ngrok-free.app/';
  // static const String API_URL = 'https://dotnet-travelers.fly.dev/';
  static const String PUBLIC_API_URL = 'https://api.foursquare.com/v3/';

  /// Token
  static const String FOUR_SQUARE_TOKEN =
      "fsq3qh6o+HDC6TCgGVeWucT3bZp1579crXXfJLM77vyTKQQ=";
}


Stream<int> watchCountNotify() async* {
  while (true) {
    final value = getIntAsync(AppConstant.keyCountNotify);
    yield value;
    await Future.delayed(const Duration(seconds: 1));
  }
}