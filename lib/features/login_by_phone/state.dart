class LoginByPhoneState {}

class LoginByPhoneLoadingState extends LoginByPhoneState {}

class LoginByPhoneFailedState extends LoginByPhoneState {
  final String message;
  LoginByPhoneFailedState({required this.message});
}

class LoginByPhoneSuccessState extends LoginByPhoneState {}
