import 'package:system_date_time_format/system_date_time_format.dart';

class SystemConfig {
  static SystemDateTimeFormat? _systemDateTimeFormat;
  static String? datePattern;
  static String? mediumDatePattern;
  static String? longDatePattern;
  static String? timePattern;

  static Future<void> initialize() async {
    _systemDateTimeFormat = SystemDateTimeFormat();
    datePattern = await _systemDateTimeFormat!.getDatePattern();
    mediumDatePattern = await _systemDateTimeFormat!.getMediumDatePattern();
    longDatePattern = await _systemDateTimeFormat!.getLongDatePattern();
    timePattern = await _systemDateTimeFormat!.getTimePattern();
  }
}
