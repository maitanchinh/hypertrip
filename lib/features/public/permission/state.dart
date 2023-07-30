import 'package:geolocator/geolocator.dart';

//Location
class CurrentLocationState {}

class LoadingCurrentLocationState extends CurrentLocationState {}

class LoadCurrentLocationFailedState extends CurrentLocationState {
  final String msg;
  LoadCurrentLocationFailedState({required this.msg});
}

class LoadCurrentLocationSuccessState extends CurrentLocationState {
  final Position location;
  LoadCurrentLocationSuccessState({required this.location});
}

//Local Network
