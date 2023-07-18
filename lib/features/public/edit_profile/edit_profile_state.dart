part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final PageState status;
  final UserProfile userProfile;
  final String error;
  final PageCommand? pageCommand;
  final File? fileNewUrl;
  final String firstName;
  final String lastName;
  final String gender;
  final String address;
  final String idUrl;
  final List<String> contacts;

  const EditProfileState({
    required this.status,
    required this.error,
    required this.userProfile,
    this.pageCommand,
    this.fileNewUrl,
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.address = '',
    this.idUrl = '',
    this.contacts = const [],
  });

  EditProfileState copyWith(
      {PageState? status,
      UserProfile? userProfile,
      String? error,
      File? fileNewUrl,
      String? firstName,
      String? lastName,
      String? gender,
      String? address,
      String? idUrl,
      List<String>? contacts,
      PageCommand? pageCommand}) {
    return EditProfileState(
      status: status ?? this.status,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
      fileNewUrl: fileNewUrl ?? this.fileNewUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      pageCommand: pageCommand ?? this.pageCommand,
      idUrl: idUrl ?? this.idUrl,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        userProfile,
        fileNewUrl,
        firstName,
        lastName,
        gender,
        address,
        pageCommand,
        idUrl,
        contacts,
      ];
}
