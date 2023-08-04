part of '../view.dart';

class DateInput extends StatefulWidget {
  const DateInput({super.key});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);

    return BlocBuilder<IncurredCostsActivityCubit, IncurredCostsActivityState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: IntrinsicWidth(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050),
                      ).then((value) {
                        if (value != null) cubit.setDate(value);
                      });
                    },
                    child: Text(state.dateTime.readableDateValue),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
