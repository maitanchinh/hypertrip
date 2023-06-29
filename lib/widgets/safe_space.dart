import 'package:flutter/cupertino.dart';

class SafeSpace extends StatelessWidget {
  final Widget child;

  const SafeSpace({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: child,
    );
  }
}
