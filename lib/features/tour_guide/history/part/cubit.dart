import 'package:bloc/bloc.dart';

import '../../../../domain/repositories/tour_guide_repo.dart';
import '../../../../utils/get_it.dart';
import 'state.dart';

final TourGuideRepo _tourGuideRepo = getIt<TourGuideRepo>();

class TourGuideHistoryCubit extends Cubit<TourGuideHistoryState> {
  final String tourGuideId;

  TourGuideHistoryCubit(this.tourGuideId) : super(TourGuideHistoryState()){
    getAssignedTour(tourGuideId);
  }

  Future<void> getAssignedTour(String TourGuideId) async {
    try {
      var tours = await _tourGuideRepo.getAssignedTour(tourGuideId);
      tours.sort((a, b) => b.trip!.endTime!.compareTo(a.trip!.endTime!));
      if (tours.isNotEmpty) {
        emit(LoadTourGuideHistorySuccessState(tours: tours));
      } else {
        emit(NoResultTourGuideHistoryState());
      }
    } on Exception catch (e) {
      emit(LoadTourGuideHistoryFailedState(msg: e.toString()));
    }
  }
}