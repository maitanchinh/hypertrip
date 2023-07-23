import 'package:flutter/cupertino.dart';

const double _padding = 32;

class SafeSpace extends StatelessWidget {
  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  const SafeSpace({
    Key? key,
    required this.child,
    this.horizontalPadding = _padding,
    this.verticalPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: child,
    );
  }

  factory SafeSpace.both({
    Key? key,
    required Widget child,
  }) {
    return SafeSpace(
      key: key,
      verticalPadding: _padding,
      child: child,
    );
  }
}
