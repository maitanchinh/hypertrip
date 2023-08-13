import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/features/tour_guide/incurred_costs_activity/state.dart';

class IncurredCostsActivityCubit extends Cubit<IncurredCostsActivityState> {
  IncurredCostsActivityCubit() : super(IncurredCostsActivityState.initial());

  void submit() {}

  void reset() {}

  IncurredCostsActivityState validate(IncurredCostsActivityState newState) {
    return newState.copyWith();
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

  void addImages(List<File> images) {
    var newState = state.copyWith(images: [...state.images, ...images]);

    onStateChanged(newState);
  }
}
