import 'package:flutter/material.dart';

class IncurredCostsActivityState {
  final TextEditingController amountController;
  final TextEditingController noteController;
  static const int maxNoteLength = 100;

  IncurredCostsActivityState({
    required this.amountController,
    required this.noteController,
  });

  factory IncurredCostsActivityState.initial() {
    var amountController = TextEditingController();
    var noteController = TextEditingController();

    noteController.addListener(() {
      if (noteController.text.length > maxNoteLength) {
        noteController.text = noteController.text.substring(0, maxNoteLength);
        noteController.selection = TextSelection.fromPosition(
          TextPosition(offset: noteController.text.length),
        );
      }
    });

    return IncurredCostsActivityState(
      amountController: amountController,
      noteController: noteController,
    );
  }

  IncurredCostsActivityState copyWith({
    TextEditingController? amountController,
    TextEditingController? noteController,
  }) {
    return IncurredCostsActivityState(
      amountController: amountController ?? this.amountController,
      noteController: noteController ?? this.noteController,
    );
  }
}
