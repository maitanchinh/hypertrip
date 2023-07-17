part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}

class FetchProfile extends EditProfileEvent {
  final UserProfile userProfile;
  const FetchProfile(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

class OnUpdateAvatar extends EditProfileEvent {
  final ImageSource imageSource;
  const OnUpdateAvatar(this.imageSource);

  @override
  List<Object> get props => [imageSource];
}

class OnSubmitUpdateInfo extends EditProfileEvent {
  const OnSubmitUpdateInfo();

  @override
  List<Object> get props => [];
}

class OnChangedFirstName extends EditProfileEvent {
  final String firstName;
  const OnChangedFirstName(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class OnChangedLastName extends EditProfileEvent {
  final String lastName;
  const OnChangedLastName(this.lastName);

  @override
  List<Object> get props => [lastName];
}

class OnChangedGender extends EditProfileEvent {
  final String gender;
  const OnChangedGender(this.gender);

  @override
  List<Object> get props => [gender];
}

class OnChangedAddress extends EditProfileEvent {
  final String address;
  const OnChangedAddress(this.address);

  @override
  List<Object> get props => [address];
}

class OnClearPageCommand extends EditProfileEvent {
  const OnClearPageCommand();

  @override
  List<Object> get props => [];
}

class AddNewContact extends EditProfileEvent {
  const AddNewContact();

  @override
  List<Object> get props => [];
}

class OnChangedContact extends EditProfileEvent {
  final int index;
  final String value;

  const OnChangedContact(this.index, this.value);

  @override
  List<Object> get props => [index, value];
}

class OnUpdateContact extends EditProfileEvent {
  const OnUpdateContact();

  @override
  List<Object> get props => [];
}

class OnNavigateToPage extends EditProfileEvent {
  final String? page;
  final dynamic argument;

  const OnNavigateToPage({
    this.page,
    this.argument,
  });

  @override
  List<Object> get props => [];
}
