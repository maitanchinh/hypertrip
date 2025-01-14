import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static const String routeName = '/loading';
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
