part of 'warning_incident_bloc.dart';

abstract class WarningIncidentEvent extends Equatable {
  const WarningIncidentEvent();
}

class FetchAllLocationTour extends WarningIncidentEvent {
  const FetchAllLocationTour();

  @override
  List<Object> get props => [];
}

class FetchDataWeather extends WarningIncidentEvent {
  final int index;
  const FetchDataWeather(this.index);

  @override
  List<Object> get props => [index];
}

class FetchDataEarthQuakes extends WarningIncidentEvent {
  const FetchDataEarthQuakes();

  @override
  List<Object> get props => [];
}
