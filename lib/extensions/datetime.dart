import 'package:hypertrip/utils/system_config.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  String get readableValue {
    final format = SystemConfig.timePattern;

    return this != null ? DateFormat(format).format(this!) : '';
  }
}
