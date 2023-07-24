import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypertrip/theme/color.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool bounce = true,
  bool expand = false,
  bool enableDrag = true,
  Radius topRadius = const Radius.circular(12),
  BoxShadow? shadow,
  double? elevation,
  Clip? clipBehavior,
  Color barrierColor = const Color.fromRGBO(0, 0, 0, 0.5),
  Duration? duration,
  ShapeBorder? shape,
  bool? isDismissible,
  Curve? animationCurve,
  bool useRootNavigator = false,
  Color? backgroundColor = AppColors.bgLightColor,
  RouteSettings? settings,
  double? closeProgressThreshold,
  Color? transitionBackgroundColor,
  Curve? previousRouteAnimationCurve,
  SystemUiOverlayStyle? overlayStyle,
  AnimationController? secondAnimation,
}) {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: builder,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    expand: expand,
    secondAnimation: secondAnimation,
    animationCurve: animationCurve,
    previousRouteAnimationCurve: previousRouteAnimationCurve,
    useRootNavigator: useRootNavigator,
    bounce: bounce,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    topRadius: topRadius,
    duration: duration,
    settings: settings,
    transitionBackgroundColor: transitionBackgroundColor,
    shadow: shadow,
    overlayStyle: overlayStyle,
    closeProgressThreshold: closeProgressThreshold,
  );
}
