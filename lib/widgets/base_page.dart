import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final bool unFocusWhenTouchOutsideInput;

  final Widget child;

  const BasePage({
    Key? key,
    required this.child,
    this.unFocusWhenTouchOutsideInput = true,
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
