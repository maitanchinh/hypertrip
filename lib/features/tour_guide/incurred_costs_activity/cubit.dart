import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/repositories/activity_repo.dart';
import 'package:hypertrip/features/root/cubit.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/features/tour_guide/activity/cubit.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/state.dart';

class IncurredCostsActivityCubit extends Cubit<IncurredCostsActivityState> {
  final ActivityRepo _activityRepo = ActivityRepo();
  final BuildContext context;

  IncurredCostsActivityCubit(this.context)
      : super(IncurredCostsActivityState.initial());

  void submit() {
    try {
      final rootState = context.read<RootCubit>().state as RootSuccessState;
      final activityState = context.read<ActivityCubit>().state;

      _activityRepo.createNewIncurredCostsActivity(
        tourGroupId: rootState.group!.id!,
        imagePaths: state.imagePaths,
        amount: state.amountFormatter.getUnformattedValue().toInt(),
        dayNo: activityState.selectedDay,
        note: state.noteController.text,
      );
    } catch (e) {}
  }

  // void reset() {}

  void init() {
    state.amountController.addListener(() {
      /// emit onStateChanged
      onStateChanged(state);
    });

    state.noteController.addListener(() {
      /// emit onStateChanged
      onStateChanged(state);

      /// limit note length
      if (state.noteController.text.length >
          IncurredCostsActivityState.maxNoteLength) {
        state.noteController.text = state.noteController.text
            .substring(0, IncurredCostsActivityState.maxNoteLength);
        state.noteController.selection = TextSelection.fromPosition(
          TextPosition(offset: state.noteController.text.length),
        );
      }
    });
  }

  IncurredCostsActivityState validate(IncurredCostsActivityState newState) {
    bool isValid = true;

    /// validate amount
    if (state.amountFormatter.getUnformattedValue() <= 0) {
      isValid = false;
    }

    /// validate note
    if (state.noteController.text.isEmpty) {
      isValid = false;
    }

    return newState.copyWith(isValid: isValid);
  }

  void onStateChanged(IncurredCostsActivityState newState) {
    emit(validate(newState));
  }

  void setDate(DateTime value) {
    var newDate = state.dateTime
        .copyWith(year: value.year, month: value.month, day: value.day);

    onStateChanged(state.copyWith(dateTime: newDate));
  }

  void setTime(DateTime value) {
    var newTime = state.dateTime
        .copyWith(hour: value.hour, minute: value.minute, second: value.second);

    onStateChanged(state.copyWith(dateTime: newTime));
  }

  void setImagePaths(List<String> imagePaths) {
    var newState = state.copyWith(imagePaths: imagePaths);

    onStateChanged(newState);
  }
}
