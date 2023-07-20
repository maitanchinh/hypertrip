part of 'warning_incident_bloc.dart';

abstract class WarningIncidentEvent extends Equatable {
  const WarningIncidentEvent();
}

class FetchAllLocationTour extends WarningIncidentEvent {
  final List<LocationTour> currentTour;
  const FetchAllLocationTour(this.currentTour);

  @override
  List<Object> get props => [currentTour];
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
