import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

import 'state.dart';

class TourDetailCubit extends Cubit<TourDetailState> {
  final TourRepo _tourRepo = getIt<TourRepo>();
  final String? tourId;

  TourDetailCubit({required this.tourId}) : super(LoadingTourDetailState()) {
    getTourDetail();
  }

  Future<void> getTourDetail() async {
    try {
      var tour = await _tourRepo.getTourDetail(tourId);

      if (tour == null) {
        emit(LoadTourDetailNotFoundState());
        return;
      }

      emit(LoadTourDetailSuccessState(tour: tour));
    } on Exception catch (e) {
      emit(LoadTourDetailFailedState(message: msg_server_error));
    }
  }
}
