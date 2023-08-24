import 'package:bloc/bloc.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/utils/get_it.dart';

import 'state.dart';

class LoginByPhoneCubit extends Cubit<LoginByPhoneState> {
  final UserRepo _userRepo = getIt<UserRepo>();
  LoginByPhoneCubit() : super(LoginByPhoneState());

  Future<void> loginByPhone(
      {required String phone, required String password}) async {
    try {
      emit(LoginByPhoneLoadingState());
      await _userRepo.login(username: phone, password: password);
      await _userRepo.getProfile();
      emit(LoginByPhoneSuccessState());
    } on Exception catch (e) {
      emit(LoginByPhoneFailedState(message: e.toString()));
    }
  }
}
