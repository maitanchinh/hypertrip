part of 'warning_incident_bloc.dart';

class WarningIncidentState {
  final PageState pageState;
  final EarthquakesResponse? earthquakesResponse;
  final String error;
  final Map<int, WeatherResponse> dataWeatherTour;
  final List<LocationTour> locationTour;
  final List<WeatherAlert> alerts;

  WarningIncidentState({
    required this.error,
    required this.earthquakesResponse,
    this.pageState = PageState.loading,
    required this.dataWeatherTour,
    required this.locationTour,
    this.alerts = const [],
  });

  WarningIncidentState copyWith({
    String? error,
    WeatherResponse? weatherResponse,
    EarthquakesResponse? earthquakesResponse,
    PageState? pageState,
    Map<int, WeatherResponse>? dataWeatherTour,
    List<LocationTour>? locationTour,
    List<WeatherAlert>? alerts,
  }) {
    return WarningIncidentState(
      error: error ?? this.error,
      earthquakesResponse: earthquakesResponse ?? this.earthquakesResponse,
      pageState: pageState ?? this.pageState,
      dataWeatherTour: dataWeatherTour ?? this.dataWeatherTour,
      locationTour: locationTour ?? this.locationTour,
      alerts: alerts ?? this.alerts,
    );
  }
}
