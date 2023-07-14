import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  //   /// When screen has [TextField] or [TextFormField]
  //   /// Default is false
  //   ///
  //   /// If this is true, then touching outside [TextField] or [TextFormField]
  //   /// will unFocus and hide the keyboard
  final bool unFocusWhenTouchOutsideInput;

  //   /// The widget below this widget in the tree.
  //   ///
  //   /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  const BaseWidget({
    Key? key,
    required this.child,
    this.unFocusWhenTouchOutsideInput = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return unFocusWhenTouchOutsideInput
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: child,
          )
        : child;
  }
}
