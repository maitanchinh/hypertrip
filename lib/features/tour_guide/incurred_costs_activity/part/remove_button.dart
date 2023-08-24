import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/cubit.dart';
import 'package:hypertrip/utils/message.dart';

class RemoveButton extends StatefulWidget {
  const RemoveButton({super.key});

  @override
  State<RemoveButton> createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<RemoveButton> {
  IncurredCostsActivityCubit? cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<IncurredCostsActivityCubit>();
  }

  Future<void> _onPressed() async {
    await showCupertinoDialog(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text(label_remove),
        content: const Text(msg_confirm_remove_activity),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("No"),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            isDefaultAction: true,
            onPressed: () {
              Navigator.of(dialogContext).pop();
              cubit
                  ?.removeDraft(cubit?.state.id ?? "")
                  .then((_) => Navigator.of(context).pop());
            },
            child: const Text("Yes"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // outline button with danger
    return OutlinedButton(
      onPressed: _onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          const BorderSide(color: Colors.red),
        ),
      ),
      child: const Text(
        label_remove,
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
