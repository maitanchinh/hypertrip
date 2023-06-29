import 'package:collection/collection.dart';
import 'package:hypertrip/domain/models/schedule/slot.dart';
import 'package:hypertrip/domain/models/tour/tour.dart';

class TourDetailState {}

class LoadingTourDetailState extends TourDetailState {}

class LoadTourDetailFailedState extends TourDetailState {
  final String message;

  LoadTourDetailFailedState({required this.message});
}

class LoadTourDetailSuccessState extends TourDetailState {
  final Tour tour;

  LoadTourDetailSuccessState({
    required this.tour,
  });

  List<int> getDays() {
    if (tour.schedules == null) return [];

    var days = tour.schedules!.map((e) => e.dayNo).toSet()
        .whereType<int>()
        .toList();

    days.sort();

    return days;
  }

  Map<int?, List<Slot>> getScheduleByDay() {
    if (tour.schedules == null) return {};

    return tour.schedules!.groupListsBy((e) => e.dayNo);
  }
}

class LoadTourDetailNotFoundState extends TourDetailState {}
