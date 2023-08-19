

import 'package:hypertrip/domain/models/tour_guide/assigned_tour.dart';

class TourGuideHistoryState {}

class LoadingTourGuideHistoryState extends TourGuideHistoryState {}

class LoadTourGuideHistoryFailedState extends TourGuideHistoryState {
  final String msg;

  LoadTourGuideHistoryFailedState({required this.msg});
}

class LoadTourGuideHistorySuccessState extends TourGuideHistoryState {
  List<AssignedTour> tours;

  LoadTourGuideHistorySuccessState({required this.tours});
}

class NoResultTourGuideHistoryState extends TourGuideHistoryState {}
