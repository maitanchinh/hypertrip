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
        return ElevatedButton(
          onPressed: () {},
          child: const Text(
            label_incurred_button_save,
          ),
        );
      },
    );
  }
}
