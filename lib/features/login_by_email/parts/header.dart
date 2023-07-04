part of '../view.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // Text(
        //   'Welcome to Hyper Trip 👏',
        //   style: TextStyle(
        //     color: Color(0xFF3460FD),
        //     fontSize: 30,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        SizedBox(height: 16),
        Text(
          'We happy to see you again. To use your account please login first.',
          style: TextStyle(
            // fontSize: 16,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 48),
      ],
    );
  }
}
