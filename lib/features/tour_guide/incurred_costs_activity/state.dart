import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:hypertrip/utils/currency_formatter.dart';

class IncurredCostsActivityState {
  final TextEditingController amountController;
  final TextEditingController noteController;
  final DateTime dateTime;
  final bool isValid;
  final bool isLoading;
  final List<String> imagePaths;
  final CurrencyTextInputFormatter amountFormatter;
  final String? activityId;

  static const int maxNoteLength = 100;
  static const int maxAmountLength = 15;

  IncurredCostsActivityState({
    required this.dateTime,
    required this.amountController,
    required this.noteController,
    required this.isValid,
    required this.isLoading,
    required this.imagePaths,
    required this.amountFormatter,
    required this.activityId,
  });

  factory IncurredCostsActivityState.initial() {
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
      amountController: TextEditingController(),
      noteController: noteController,
      dateTime: DateTime.now(),
      isValid: false,
      isLoading: false,
      imagePaths: [],
      amountFormatter: CurrencyFormatter.vi,
      activityId: null,
    );
  }

  IncurredCostsActivityState copyWith({
    TextEditingController? amountController,
    TextEditingController? noteController,
    DateTime? dateTime,
    bool? isValid,
    bool? isLoading,
    List<String>? imagePaths,
    CurrencyTextInputFormatter? amountFormatter,
    String? activityId,
  }) {
    return IncurredCostsActivityState(
      amountController: amountController ?? this.amountController,
      noteController: noteController ?? this.noteController,
      dateTime: dateTime ?? this.dateTime,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      imagePaths: imagePaths ?? this.imagePaths,
      amountFormatter: amountFormatter ?? this.amountFormatter,
      activityId: activityId ?? this.activityId,
    );
  }
}
