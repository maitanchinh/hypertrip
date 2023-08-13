part of '../view.dart';

class TimeInput extends StatefulWidget {
  const TimeInput({super.key});

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);

    return BlocBuilder<IncurredCostsActivityCubit, IncurredCostsActivityState>(
      builder: (context, state) {
        return SizedBox(
          height: 60,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            child: CupertinoDatePicker(
              use24hFormat: true,
              mode: CupertinoDatePickerMode.time,
              initialDateTime: state.dateTime,
              onDateTimeChanged: (value) {
                cubit.setTime(value);
              },
            ),
          ),
        );
      },
    );
  }
}
