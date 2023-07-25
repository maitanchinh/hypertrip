import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/incidents/earth_quakes_response.dart';
import 'package:hypertrip/domain/models/incidents/weather_alert.dart';
import 'package:hypertrip/domain/models/incidents/weather_alerts.dart';
import 'package:hypertrip/domain/models/incidents/weather_current.dart';
import 'package:hypertrip/domain/models/incidents/weather_forecast.dart';
import 'package:hypertrip/domain/models/incidents/weather_location.dart';
import 'package:hypertrip/domain/models/incidents/weather_response.dart';
import 'package:hypertrip/domain/repositories/warning_incident_repository.dart';
import 'package:hypertrip/utils/page_states.dart';

part 'warning_incident_event.dart';
part 'warning_incident_state.dart';

class WarningIncidentBloc extends Bloc<WarningIncidentEvent, WarningIncidentState> {
  final WarningIncidentRepository _warningIncidentRepository;

  WarningIncidentBloc(this._warningIncidentRepository)
      : super(WarningIncidentState(
          earthquakesResponse: null,
          error: '',
          dataWeatherTour: {},
          locationTour: [],
        )) {
    on<FetchAllLocationTour>(_fetchAllLocationTour);
    on<FetchAllAlert>(_fetchAllAlert);
    on<FetchDataWeather>(_fetchDataWeather);
    on<FetchDataEarthQuakes>(_fetchDataEarthQuakes);
  }

  FutureOr<void> _fetchDataWeather(
      FetchDataWeather event, Emitter<WarningIncidentState> emit) async {
    try {
      emit(state.copyWith(
        pageState: PageState.loading,
      ));

      final result = await _warningIncidentRepository.fetchDataWeather(
        lat: state.locationTour[event.index].lat,
        lng: state.locationTour[event.index].lng,
      );

      final updatedDataWeatherTour = state.dataWeatherTour.map((key, value) {
        if (key == event.index) {
          return MapEntry(
              key,
              value.copyWith(
                  forecast: result.forecast,
                  current: result.current,
                  alerts: result.alerts,
                  location: result.location));
        }
        return MapEntry(key, value);
      });

      emit(state.copyWith(
        weatherResponse: result,
        pageState: PageState.success,
        dataWeatherTour: updatedDataWeatherTour,
      ));

      // Nếu có data Alert thì gửi Api warning
    } catch (e) {
      emit(state.copyWith(error: e.toString(), pageState: PageState.failure));
    }
  }

  FutureOr<void> _fetchDataEarthQuakes(
      FetchDataEarthQuakes event, Emitter<WarningIncidentState> emit) async {
    try {
      final result = await _warningIncidentRepository.fetchDataEarthQuakes();

      emit(state.copyWith(earthquakesResponse: result));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  FutureOr<void> _fetchAllLocationTour(
      FetchAllLocationTour event, Emitter<WarningIncidentState> emit) {

    final Map<int, WeatherResponse> dataWeatherTour = {};
    for (int i = 0; i < event.currentTour.length; i++) {
      dataWeatherTour[i] = WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      );
    }

    emit(state.copyWith(dataWeatherTour: dataWeatherTour, locationTour: event.currentTour));

    add(const FetchDataWeather(0));
    add(const FetchDataEarthQuakes());
  }

  FutureOr<void> _fetchAllAlert(FetchAllAlert event, Emitter<WarningIncidentState> emit) async {
    final results = await _warningIncidentRepository.getAlertTrip(event.tripId);
    emit(state.copyWith(alerts: results));
  }
}

class LocationTour {
  double lat;
  double lng;
  LocationTour({required this.lat, required this.lng});
}
