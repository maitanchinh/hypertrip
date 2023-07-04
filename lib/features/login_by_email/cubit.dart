import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/utils/get_it.dart';

import 'state.dart';

class LoginByEmailCubit extends Cubit<LoginByEmailState> {
  final UserRepo _userRepo = getIt<UserRepo>();

  LoginByEmailCubit() : super(LoginByEmailState());

  Future<void> loginByEmail(
      {required String email, required String password}) async {
    try {
      emit(LoginByEmailLoadingState());
      await _userRepo.login(username: email, password: password);
      emit(LoginByEmailSuccessState());
    } on Exception catch (e) {
      emit(LoginByEmailFailedState(message: e.toString()));
    }
  }
}
