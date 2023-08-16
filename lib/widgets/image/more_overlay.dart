import 'package:flutter/material.dart';

class MoreOverlay extends StatelessWidget {
  final String text;
  const MoreOverlay(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: black.withOpacity(opacity)),
        color: Colors.black.withOpacity(0.3),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
      ),
    );
  }
}
