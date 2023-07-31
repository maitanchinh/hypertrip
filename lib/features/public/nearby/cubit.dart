import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/features/public/permission/cubit.dart';
import 'package:hypertrip/features/public/permission/state.dart';
import 'package:hypertrip/utils/get_it.dart';

import 'state.dart';

final FoursquareRepo _foursquareRepo = getIt<FoursquareRepo>();

//Nearby Place
class NearbyPlaceCubit extends Cubit<NearbyPlaceState> {
  final CurrentLocationCubit currentLocationCubit =
      getIt<CurrentLocationCubit>();

  NearbyPlaceCubit() : super(NearbyPlaceState()) {
    getNearbyPlace('');
  }

  Future<void> getNearbyPlace(String query) async {
    try {
      emit(LoadingNearbyPlaceState());
      var place = await _foursquareRepo.getNearbyPlace(
          query,
          (currentLocationCubit.state as LoadCurrentLocationSuccessState)
              .location);
      if (place!.results!.isEmpty) {
        emit(NoResultsNearbyPlaceState());
      } else {
        emit(LoadNearbyPlaceSuccessState(nearbyPlace: place));
      }
    } on Exception catch (e) {
      emit(LoadNearbyPlaceFailedState(message: e.toString()));
    }
  }

  void refresh() {
    emit(LoadingNearbyPlaceState());
    getNearbyPlace('');
  }
}
