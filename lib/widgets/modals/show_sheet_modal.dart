import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showSheetModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color backgroundColor = Colors.transparent,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color barrierColor = const Color.fromRGBO(0, 0, 0, 0.5),
  bool bounce = true,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = false,
  Widget? topControl,
  Duration? duration,
  RouteSettings? settings,
  SystemUiOverlayStyle? overlayStyle,
  double? closeProgressThreshold,
}) {
  return showBarModalBottomSheet<T>(
    context: context,
    builder: builder,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    bounce: bounce,
    expand: expand,
    secondAnimation: secondAnimation,
    animationCurve: animationCurve,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    topControl: topControl,
    duration: duration,
    settings: settings,
    overlayStyle: overlayStyle,
    closeProgressThreshold: closeProgressThreshold,
  );
}
