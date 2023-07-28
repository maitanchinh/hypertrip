part of '../view.dart';

class ActivityEmpty extends StatelessWidget {
  const ActivityEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        msg_activity_empty,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
