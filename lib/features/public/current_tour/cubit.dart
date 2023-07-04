import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/utils/get_it.dart';
import 'package:hypertrip/utils/message.dart';

import 'state.dart';

class CurrentTourCubit extends Cubit<CurrentTourState> {
  final GroupRepo _groupRepo = getIt<GroupRepo>();
  final TourRepo _tourRepo = getIt<TourRepo>();

  CurrentTourCubit() : super(LoadingCurrentTourState()) {
    getCurrentTour();
  }

  void getCurrentTour() async {
    try {
      var group = await _groupRepo.getCurrentGroup();
      if (group == null) {
        emit(LoadCurrentTourNotFoundState());
        return;
      }

      var members = await _groupRepo.getMembers(group.id);
      var schedule = await _tourRepo.getSchedule(group.trip?.tourId);

      emit(LoadCurrentTourSuccessState(
          group: group, members: members, schedule: schedule));
    } on Exception catch (_) {
      emit(LoadCurrentTourFailedState(message: msg_server_error));
    }
  }

  void refresh() {
    emit(LoadingCurrentTourState());
    getCurrentTour();
  }
}
