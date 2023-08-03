import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/utils/message.dart';
import 'package:hypertrip/utils/page_command.dart';
import 'package:hypertrip/utils/page_states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserRepo _userRepo;
  final TourRepo _tourGuideRepo;

  EditProfileBloc(this._userRepo, this._tourGuideRepo)
      : super(
          EditProfileState(
            error: '',
            status: PageState.loading,
            userProfile: UserProfile(
                id: '',
                phone: '',
                firstName: '',
                lastName: '',
                gender: '',
                role: '',
                status: '',
                avatarUrl: ''),
          ),
        ) {
    on<FetchProfile>(_fetchProfile);
    on<OnUpdateAvatar>(_onUpdateAvatar);
    on<OnChangedFirstName>(_onChangedFirstName);
    on<OnChangedLastName>(_onChangedLastName);
    on<OnChangedGender>(_onChangedGender);
    on<OnChangedAddress>(_onChangedAddress);
    on<OnSubmitUpdateInfo>(_onSubmitUpdateInfo);

    on<AddNewContact>(_addNewContact);
    on<OnChangedContact>(_onChangedContact);
    on<OnUpdateContact>(_onUpdateContact);

    on<OnNavigateToPage>(_onNavigateToPage);
    on<OnClearPageCommand>((event, emit) => emit(state.copyWith(pageCommand: null)));
  }

  FutureOr<void> _fetchProfile(FetchProfile event, Emitter emit) async {
    try {
      List<String> contacts = [];
      contacts.add(event.userProfile.firstContactNumber);
      contacts.add(event.userProfile.secondContactNumber);

      contacts.removeWhere((contact) => contact.isEmpty);

      emit(state.copyWith(
        userProfile: event.userProfile,
        status: PageState.success,
        firstName: event.userProfile.firstName,
        lastName: event.userProfile.lastName,
        address: event.userProfile.address,
        gender: event.userProfile.gender,
        contacts: contacts,
      ));
    } catch (ex) {
      emit(state.copyWith(status: PageState.failure, error: ex.toString()));
    }
  }

  final ImagePicker _imagePicker = ImagePicker();

  void _onUpdateAvatar(OnUpdateAvatar event, Emitter emit) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: event.imageSource);
      if (image != null) {
        File imageFile = File(image.path);

        final res = await _userRepo.attachmentsFile(imageFile);

        if (res == null) {
          toast(update_avatar_failed);
        } else {
          emit(
            state.copyWith(
              userProfile: state.userProfile.copyWith(avatarUrl: res['url']),
              idUrl: res['id'],
            ),
          );
        }
      } else {
        emit(state.copyWith(fileNewUrl: null));
      }
    } catch (e) {
      emit(state.copyWith(fileNewUrl: null));
    }
  }

  FutureOr<void> _onSubmitUpdateInfo(event, Emitter<EditProfileState> emit) async {
    final res = await _userRepo.updateInfo(
      state.firstName,
      state.lastName,
      state.gender,
      state.address,
      state.idUrl,
    );

    if (res != null) {
      final profile = state.userProfile;

      toast(update_info_success);
      emit(
        state.copyWith(
          pageCommand: PageCommandNavigatorPage(
            page: null,
            argument: state.userProfile.copyWith(
                firstName: state.firstName,
                lastName: state.lastName,
                address: state.address,
                gender: state.gender,
                avatarUrl: profile.avatarUrl),
          ),
        ),
      );
    } else {
      toast(update_info_failed);
    }
  }

  FutureOr<void> _onChangedFirstName(OnChangedFirstName event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  FutureOr<void> _onChangedLastName(OnChangedLastName event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  FutureOr<void> _onChangedGender(OnChangedGender event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(gender: event.gender));
  }

  FutureOr<void> _onChangedAddress(OnChangedAddress event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(address: event.address));
  }

  FutureOr<void> _addNewContact(AddNewContact event, Emitter<EditProfileState> emit) {
    if (state.contacts.length < 2) {
      final contactsClone = List<String>.from(state.contacts);
      contactsClone.add('');
      final updatedState = state.copyWith(contacts: contactsClone);
      emit(updatedState);
    }
  }

  FutureOr<void> _onUpdateContact(OnUpdateContact event, Emitter<EditProfileState> emit) async {
    final response = await _tourGuideRepo.updateContacts(state.userProfile.id ?? '', state.contacts);
    if (response != null) {
      toast(update_info_success);
      emit(state.copyWith(
        userProfile: response,
      ));
    } else {
      toast(update_info_failed);
    }
  }

  FutureOr<void> _onChangedContact(OnChangedContact event, Emitter<EditProfileState> emit) {
    final contactsClone = List<String>.from(state.contacts);
    contactsClone[event.index] = event.value;
    final updatedState = state.copyWith(contacts: contactsClone);
    emit(updatedState);
  }

  FutureOr<void> _onNavigateToPage(event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(
        pageCommand: PageCommandNavigatorPage(page: event.page, argument: event.argument)));
  }
}
