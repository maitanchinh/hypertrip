import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtils {
  static String convertTimeToTimeAgo(DateTime? createdDate) {
    if (createdDate == null) return '';
    final result = timeago.format(createdDate, locale: 'en');
    return result;
  }

  static DateTime get today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static String convertDateTimeString(DateTime? dateTime, {String format = 'yyyy-MM-dd'}) {
    if (dateTime == null) return '';

    if (dateTime.year == today.year && dateTime.month == today.month && dateTime.day == today.day) {
      return 'Today';
    }

    return DateFormat(format).format(dateTime);
  }

  static String convertToHHMMString(String time, {String format = "HH:mm a"}) {
    if (time.isEmpty) return '';
    try {
      final dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(time);
      final hhmmFormat = DateFormat(format);
      return hhmmFormat.format(dateTime);
    } catch (ex) {
      return '';
    }
  }

  static String convertTimeToDayOfWeek(String time) {
    DateTime dateTime = DateTime.parse(time);
    String dayOfWeek = DateFormat('EEEE').format(dateTime);
    return dayOfWeek;
  }

  static String convertTimeToDayAndMonthString(String time) {
    DateTime dateTime = DateTime.parse(time);
    String day = DateFormat('dd').format(dateTime);
    String month = DateFormat.MMM().format(dateTime);
    return '$day $month';
  }
}
