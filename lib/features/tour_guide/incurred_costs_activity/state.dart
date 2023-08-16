import 'dart:io';

import 'package:flutter/material.dart';

class IncurredCostsActivityState {
  final TextEditingController amountController;
  final TextEditingController noteController;
  final DateTime dateTime;
  final bool isValid;
  final bool isLoading;
  final List<File> images;

  static const int maxNoteLength = 100;
  static const int maxAmountLength = 15;

  IncurredCostsActivityState({
    required this.dateTime,
    required this.amountController,
    required this.noteController,
    required this.isValid,
    required this.isLoading,
    required this.images,
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
      images: [],
    );
  }

  IncurredCostsActivityState copyWith({
    TextEditingController? amountController,
    TextEditingController? noteController,
    DateTime? dateTime,
    bool? isValid,
    bool? isLoading,
    List<File>? images,
  }) {
    return IncurredCostsActivityState(
      amountController: amountController ?? this.amountController,
      noteController: noteController ?? this.noteController,
      dateTime: dateTime ?? this.dateTime,
      isValid: isValid ?? this.isValid,
      isLoading: isLoading ?? this.isLoading,
      images: images ?? this.images,
    );
  }
}
