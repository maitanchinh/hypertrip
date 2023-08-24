part of '../view.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({super.key});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<IncurredCostsActivityCubit>(context);

    return BlocBuilder<IncurredCostsActivityCubit, IncurredCostsActivityState>(
      builder: (context, state) {
        return BlocBuilder<IncurredCostsActivityCubit,
            IncurredCostsActivityState>(
          buildWhen: (previous, current) =>
              previous.isAmountValid != current.isAmountValid ||
              previous.isNoteValid != current.isNoteValid,
          builder: (context, state) {
            return ElevatedButton(
              onPressed:
                  state.isAmountValid && state.isNoteValid ? _onPressed : null,
              child: Text(
                state.id == null ? label_incurred_button_save : label_save,
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _onPressed() async {
    var cubit = context.read<IncurredCostsActivityCubit>();
    if (cubit.state.id != null && await cubit.update()) {
      Navigator.of(context).pop();
    } else if (await cubit.create()) {
      Navigator.of(context).pop();
    }
  }
}
