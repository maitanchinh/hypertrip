import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/models/discovery/nearby_response.dart';

import '../../data/repositories/repositories.dart';
import 'nearby_event.dart';
import 'nearby_state.dart';

class PlaceBloc extends Bloc<dynamic, PlaceState> {
  final PlaceRepository _placeRepository;
  PlaceBloc(this._placeRepository) : super(PlaceLoadingState()) {
    on<LoadPlaceEvent>((event, emit) async {
      emit(PlaceLoadingState());
      try {
        final places = await _placeRepository.getNearbyPlaces();
        emit(PlaceLoadedState(places));
      } catch (e) {
        emit(PlaceErrorState(e.toString()));
      }
    });
  }
}
