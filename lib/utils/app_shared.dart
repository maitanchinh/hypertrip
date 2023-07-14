

import 'package:hypertrip/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

Stream<int> watchCountNotify() async* {
  while (true) {
    final value = getIntAsync(AppConstant.keyCountNotify);
    yield value;
    await Future.delayed(const Duration(seconds: 1));
  }
}