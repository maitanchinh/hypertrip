import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';

@immutable
abstract class PlaceState extends Equatable {}

class PlaceLoadingState extends PlaceState {
  @override
  List<Object?> get props => [];
}

class PlaceLoadedState extends PlaceState {
  PlaceLoadedState(this.places);
  final NearbyPlacesResponse places;
  @override
  List<Object?> get props => [places];
}

class PlaceErrorState extends PlaceState {
  PlaceErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
