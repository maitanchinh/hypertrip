import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/incidents/earth_quakes_response.dart';
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
    // Lấy danh sách vị trí trong tour
    final List<LocationTour> locationTour = [
      LocationTour(lat: 10.762622, lng: 106.660172),
      LocationTour(lat: 10.502307, lng: 107.169205),
      LocationTour(lat: 12.24507, lng: 109.19432),
      LocationTour(lat: 13.759660, lng: 109.206123),
      LocationTour(lat: 15.12047, lng: 108.79232),
    ];

    final Map<int, WeatherResponse> dataWeatherTour = {
      0: WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      ),
      1: WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      ),
      2: WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      ),
      3: WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      ),
      4: WeatherResponse(
        location: WeatherLocation(),
        alerts: WeatherAlerts(),
        current: WeatherCurrent(),
        forecast: WeatherForecast(),
      ),
    };

    emit(state.copyWith(dataWeatherTour: dataWeatherTour, locationTour: locationTour));

    add(const FetchDataWeather(0));
    add(const FetchDataEarthQuakes());
  }
}

class LocationTour {
  double lat;
  double lng;
  LocationTour({required this.lat, required this.lng});
}
