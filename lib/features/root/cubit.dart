import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/features/root/state.dart';
import 'package:hypertrip/utils/get_it.dart';

class RootCubit extends Cubit<RootState> {
  final groupRepo = getIt<GroupRepo>();
  RootCubit() : super(RootInitState());

  Future<void> load() async {
    emit(RootLoadingState());
    await _getCurrentGroup();
  }

  Future<void> _getCurrentGroup() async {
    try {
      final group = await groupRepo.getCurrentGroup();
      emit(RootSuccessState(group: group));
    } catch (e) {
      emit(RootErrorState(e.toString()));
    }
  }
  
}
