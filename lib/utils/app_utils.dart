import 'dart:io';

class AppUtils {
  static String formatPhoneNumber(
    String phoneNumber, {
    String dialCode = '+84',
    bool isIOS = false,
    bool formatStr = false,
  }) {
    if (phoneNumber.isEmpty) return phoneNumber;
    if (!isIOS) {
      if (phoneNumber.startsWith("0")) {
        return phoneNumber;
      } else if (phoneNumber.startsWith(dialCode)) {
        return phoneNumber.replaceFirst(dialCode, "0");
      } else {
        final str = dialCode + phoneNumber;
        if (formatStr) {
          final format = str.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");
          return format;
        }
        return str;
      }
    } else {
      String dialCodeIOS = dialCode.replaceFirst("+", '00');
      if (phoneNumber.startsWith("0")) {
        return phoneNumber.replaceFirst("0", dialCodeIOS);
      } else if (phoneNumber.startsWith(dialCode)) {
        return phoneNumber.replaceFirst("+", "00");
      } else {
        final str = dialCodeIOS + phoneNumber;
        if (formatStr) {
          final format = str.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ");
          return format;
        }
        return str;
      }
    }
  }

  /// Size is MB
  static bool isMaxFileSize(File file, {int size = 100}) {
    int bytes = file.lengthSync();
    int maxFileSize = size * 1024 * 1024;

    if (bytes > maxFileSize + 1) {
      return true;
    }
    return false;
  }
}
