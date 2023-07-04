part of '../view.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(shape: defaultButtonRoundedShape),
            onPressed: () {
              Navigator.pushNamed(context, LoginByPhonePage.routeName);
            },
            child: const Text(
              'Login as traveler',
            ),
          ),
        ),
      ],
    );
  }
}
