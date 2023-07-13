import 'package:nb_utils/nb_utils.dart';

extension StringFilter on String {
  bool applySearch(String value) => toLowerCase()
      .removeAllWhiteSpace()
      .contains(value.toLowerCase().removeAllWhiteSpace());
}
