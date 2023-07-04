class LoginByEmailState {}

class LoginByEmailLoadingState extends LoginByEmailState {}

class LoginByEmailFailedState extends LoginByEmailState {
  final String message;

  LoginByEmailFailedState({required this.message});
}

class LoginByEmailSuccessState extends LoginByEmailState {}
