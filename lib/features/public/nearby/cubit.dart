import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/utils/get_it.dart';

import 'state.dart';

final FoursquareRepo _foursquareRepo = getIt<FoursquareRepo>();

//Nearby Place
class NearbyPlaceCubit extends Cubit<NearbyPlaceState> {
  NearbyPlaceCubit() : super(NearbyPlaceState()) {
    getNearbyPlace('');
  }

  Future<void> getNearbyPlace(String query) async {
    try {
      emit(LoadingNearbyPlaceState());
      var place = await _foursquareRepo.getNearbyPlace(query);
      if (place!.results!.isEmpty) {
        emit(NoResultsNearbyPlaceState());
      } else {
        emit(LoadNearbyPlaceSuccessState(nearbyPlace: place));
      }
    } on Exception catch (e) {
      emit(LoadNearbyPlaceFailedState(message: e.toString()));
    }
  }
}

//Place Photo
class PlacePhotoCubit extends Cubit<PlacePhotoState> {
  PlacePhotoCubit(String? placeId) : super(PlacePhotoState()) {
    getPlacePhoto(placeId!);
  }
  Future<void> getPlacePhoto(String placeId) async {
    try {
      emit(LoadingPlacePhotoState());
      var photos = await _foursquareRepo.getPlacePhoto(placeId);
      if (photos.isEmpty) {
        emit(NoResultPlacePhotoState());
      } else {
        emit(LoadPlacePhotoSuccessState(photos: photos));
      }
    } on Exception catch (e) {
      emit(LoadPlacePhotoFailedState(message: e.toString()));
    }
  }
}

//Place Tip
class PlaceTipCubit extends Cubit<PlaceTipState> {
  PlaceTipCubit(String? placeId) : super(PlaceTipState()) {}

  Future<void> getPlaceTip(String placeId) async {
    try {} on Exception catch (e) {}
  }
}
