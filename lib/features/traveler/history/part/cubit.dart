import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/traveler_repo.dart';
import 'package:hypertrip/features/traveler/history/part/state.dart';

import '../../../../utils/get_it.dart';

final TravelerRepo _travelerRepo = getIt<TravelerRepo>();

class TravelerHistoryCubit extends Cubit<TravelerHistoryState> {
  final String travelerId;

  TravelerHistoryCubit(this.travelerId) : super(TravelerHistoryState()){
    getJoinedTour(travelerId);
  }

  Future<void> getJoinedTour(String travelerId) async {
    try {
      var tours = await _travelerRepo.getJoinedTour(travelerId);
      tours.sort((a, b) => b.trip!.endTime!.compareTo(a.trip!.endTime!));
      if (tours.isNotEmpty) {
        emit(LoadTravelerHistorySuccessState(tours: tours));
      } else {
        emit(NoResultTravelerHistoryState());
      }
    } on Exception catch (e) {
      emit(LoadTravelerHistoryFailedState(msg: e.toString()));
    }
  }
}