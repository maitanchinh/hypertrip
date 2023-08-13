import 'package:hypertrip/utils/system_config.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String get readableDateTimeValue {
    final dateFormat = SystemConfig.datePattern;
    final timeFormat = SystemConfig.timePattern;

    if (this == null) {
      return '';
    } else {
      return DateFormat('$dateFormat $timeFormat').format(this!);
    }
  }

  String get readableTimeValue {
    final format = SystemConfig.timePattern;

    return this != null ? DateFormat(format).format(this!) : '';
  }

  String get readableDateValue {
    final format = SystemConfig.datePattern;

    return this != null ? DateFormat(format).format(this!) : '';
  }
}
