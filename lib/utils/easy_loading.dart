import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hypertrip/theme/color.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.primaryColor
    ..backgroundColor = AppColors.bgLightColor
    ..indicatorColor = AppColors.primaryColor
    ..textColor = AppColors.textColor
    ..maskColor = AppColors.primaryColor
    ..userInteractions = true
    ..dismissOnTap = false;
}
