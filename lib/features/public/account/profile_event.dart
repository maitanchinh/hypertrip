part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class FetchProfile extends ProfileEvent {
  const FetchProfile();

  @override
  List<Object> get props => [];
}

class FetchTravelInfo extends ProfileEvent {
  final String uID;
  const FetchTravelInfo(this.uID);

  @override
  List<Object> get props => [uID];
}

class UpdateProfile extends ProfileEvent {
  final UserProfile userProfile;
  const UpdateProfile(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class OnChangedCurrentPass extends ProfileEvent {
  final String currentPass;
  const OnChangedCurrentPass(this.currentPass);

  @override
  List<Object> get props => [currentPass];
}

class OnChangedNewPass extends ProfileEvent {
  final String newPass;
  const OnChangedNewPass(this.newPass);

  @override
  List<Object> get props => [newPass];
}

class OnChangedConfirmPass extends ProfileEvent {
  final String confirmPass;
  const OnChangedConfirmPass(this.confirmPass);

  @override
  List<Object> get props => [confirmPass];
}

class OnSubmitUpdatePass extends ProfileEvent {
  const OnSubmitUpdatePass();

  @override
  List<Object> get props => [];
}

class FetchContacts extends ProfileEvent {
  const FetchContacts();

  @override
  List<Object> get props => [];
}

class OnClearPageCommand extends ProfileEvent {
  const OnClearPageCommand();

  @override
  List<Object> get props => [];
}
