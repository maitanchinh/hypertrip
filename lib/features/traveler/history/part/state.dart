import 'package:hypertrip/domain/models/traveler/joined_tour.dart';

class TravelerHistoryState {}

class LoadingTravelerHistoryState extends TravelerHistoryState {}

class LoadTravelerHistoryFailedState extends TravelerHistoryState {
  final String msg;

  LoadTravelerHistoryFailedState({required this.msg});
}

class LoadTravelerHistorySuccessState extends TravelerHistoryState {
  List<JoinedTour> tours;

  LoadTravelerHistorySuccessState({required this.tours});
}

class NoResultTravelerHistoryState extends TravelerHistoryState {}
