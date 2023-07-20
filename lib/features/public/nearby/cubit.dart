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
