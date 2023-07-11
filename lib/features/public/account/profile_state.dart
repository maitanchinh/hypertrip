part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final PageState status;
  final UserProfile userProfile;
  final String error;
  final PageCommand? pageCommand;
  final GlobalKey<FormState> formPassKey;
  final String currentPass;
  final String newPass;
  final String confirmPass;
  final bool setAutoValidateFormPass;
  final List<String> contacts;
  final int tourCount;

  const ProfileState({
    required this.status,
    required this.error,
    required this.userProfile,
    this.pageCommand,
    required this.formPassKey,
    this.currentPass = '',
    this.newPass = '',
    this.confirmPass = '',
    this.setAutoValidateFormPass = false,
    this.contacts = const [],
    this.tourCount = 0,
  });

  ProfileState copyWith({
    PageState? status,
    UserProfile? userProfile,
    String? error,
    PageCommand? pageCommand,
    GlobalKey<FormState>? formPassKey,
    String? currentPass,
    String? newPass,
    String? confirmPass,
    bool? setAutoValidateFormPass,
    List<String>? contacts,
    int? tourCount,
  }) {
    return ProfileState(
      status: status ?? this.status,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
      pageCommand: pageCommand,
      formPassKey: formPassKey ?? this.formPassKey,
      currentPass: currentPass ?? this.currentPass,
      newPass: newPass ?? this.newPass,
      confirmPass: confirmPass ?? this.confirmPass,
      setAutoValidateFormPass: setAutoValidateFormPass ?? this.setAutoValidateFormPass,
      contacts: contacts ?? this.contacts,
      tourCount: tourCount ?? this.tourCount,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        userProfile,
        pageCommand,
        formPassKey,
        currentPass,
        setAutoValidateFormPass,
        newPass,
        confirmPass,
        contacts,
      ];
}
