import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  const ActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // radius: 17,
      backgroundColor: Colors.black.withOpacity(0.2),
      child: Center(
        child: IconButton(
          icon: Transform.scale(
            scale: 0.8,
            child: SvgPicture.asset(
              icon,
              color: white,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
