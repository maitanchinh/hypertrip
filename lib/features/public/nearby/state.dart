import 'package:hypertrip/domain/models/nearby/nearby_place.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place_photo.dart';
import 'package:hypertrip/domain/models/nearby/nearby_place_tip.dart';

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

//Place Photo
class PlacePhotoState {}

class LoadingPlacePhotoState extends PlacePhotoState {}

class NoResultPlacePhotoState extends PlacePhotoState {}

class LoadPlacePhotoFailedState extends PlacePhotoState {
  final String message;
  LoadPlacePhotoFailedState({required this.message});
}

class LoadPlacePhotoSuccessState extends PlacePhotoState {
  final List<NearbyPlacePhoto> photos;
  LoadPlacePhotoSuccessState({required this.photos});
}

//Place Tip
class PlaceTipState {}

class LoadingPlaceTipState extends PlaceTipState {}

class NoResultPlaceTipState extends PlaceTipState {}

class LoadPlaceTipSuccessState extends PlaceTipState {
  final List<Tip> tips;
  LoadPlaceTipSuccessState({required this.tips});
}

class LoadPlaceTipFailedState extends PlaceTipState {}
