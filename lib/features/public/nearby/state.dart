import 'package:hypertrip/domain/models/nearby/nearby_place.dart';

// Nearby Place
class NearbyPlaceState {}

class LoadingNearbyPlaceState extends NearbyPlaceState {}

class NoResultsNearbyPlaceState extends NearbyPlaceState {}

class LoadNearbyPlaceFailedState extends NearbyPlaceState {
  final String message;
  LoadNearbyPlaceFailedState({required this.message});
}

class LoadNearbyPlaceSuccessState extends NearbyPlaceState {
  final NearbyPlace? nearbyPlace;

  LoadNearbyPlaceSuccessState({required this.nearbyPlace});
}
