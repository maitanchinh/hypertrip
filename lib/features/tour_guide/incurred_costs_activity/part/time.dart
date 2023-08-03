part of '../view.dart';

class Time extends StatelessWidget {
  const Time({super.key});

  @override
  Widget build(BuildContext context) {
    var activityCubit = BlocProvider.of<ActivityCubit>(context);
    var activityState = activityCubit.state;

    return Container(
      width: double.infinity,
      color: Colors.amber,
      height: 20,
      child: const Center(child: Text('Time')),
    );
  }
}
