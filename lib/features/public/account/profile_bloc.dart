import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/user/user_profile.dart';
import 'package:hypertrip/domain/repositories/foursquare_repo.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/user_repo.dart';
import 'package:hypertrip/utils/message.dart' as message;
import 'package:hypertrip/utils/page_command.dart';
import 'package:hypertrip/utils/page_states.dart';
import 'package:nb_utils/nb_utils.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepo _userRepo;
  final FoursquareRepo _foursquareRepo;
  final GroupRepo _groupRepo;

  ProfileBloc(this._userRepo, this._foursquareRepo, this._groupRepo)
      : super(
          ProfileState(
            error: '',
            status: PageState.success,
            userProfile: UserProfile(
                id: '',
                phone: '',
                firstName: '',
                lastName: '',
                gender: '',
                role: '',
                status: '',
                avatarUrl: ''),
            formPassKey: GlobalKey<FormState>(),
          ),
        ) {
    on<FetchProfile>(_fetchProfile);
    on<FetchTravelInfo>(_fetchTravelInfo);
    on<OnChangedCurrentPass>(_onChangedCurrentPass);
    on<OnChangedNewPass>(_onChangedNewPass);
    on<OnChangedConfirmPass>(_onChangedConfirmPass);
    on<OnSubmitUpdatePass>(_onSubmitUpdatePass);

    on<UpdateProfile>(_updateProfile);
    on<OnSubmitSendEmergency>(_onSubmitSendEmergency);
    on<OnClearPageCommand>((event, emit) => emit(state.copyWith(pageCommand: null)));
  }

  FutureOr<void> _fetchProfile(event, Emitter emit) async {
    try {
      emit(state.copyWith(status: PageState.loading));
      final response = await _userRepo.getProfile();

      List<String> contacts = [];
      contacts.add(response.firstContactNumber);
      contacts.add(response.secondContactNumber);

      contacts.removeWhere((contact) => contact.isEmpty);

      emit(state.copyWith(userProfile: response, contacts: contacts));

      add(FetchTravelInfo(response.id ?? ''));
    } catch (ex) {
      emit(state.copyWith(status: PageState.failure, error: ex.toString()));
    }
  }

  FutureOr<void> _onChangedCurrentPass(
      OnChangedCurrentPass event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(currentPass: event.currentPass));
  }

  FutureOr<void> _onChangedNewPass(OnChangedNewPass event, Emitter<ProfileState> emit) {
    emit(state.copyWith(newPass: event.newPass));
  }

  FutureOr<void> _onChangedConfirmPass(OnChangedConfirmPass event, Emitter<ProfileState> emit) {
    emit(state.copyWith(confirmPass: event.confirmPass));
  }

  FutureOr<void> _onSubmitUpdatePass(OnSubmitUpdatePass event, Emitter<ProfileState> emit) async {
    // emit(state.copyWith(setAutoValidateFormPass: true));

    if (state.formPassKey.currentState?.validate() ?? false) {
      await _userRepo.updatePassword(state.newPass);

      toast(message.update_password_success);
      emit(state.copyWith(setAutoValidateFormPass: false, pageCommand: PageCommandNavigatorPage()));
    }
  }

  FutureOr<void> _updateProfile(UpdateProfile event, Emitter<ProfileState> emit) {
    emit(state.copyWith(userProfile: event.userProfile));
  }

  FutureOr<void> _fetchTravelInfo(FetchTravelInfo event, Emitter<ProfileState> emit) async {
    final response = await _userRepo.getTravelInfo(event.uID);

    emit(state.copyWith(status: PageState.success, tourCount: response));
  }

  FutureOr<void> _onSubmitSendEmergency(
      OnSubmitSendEmergency event, Emitter<ProfileState> emit) async {
    final permissionGeo = await _foursquareRepo.isPermissionGeolocation();

    emit(state.copyWith(status: PageState.loadingFull));
    if (permissionGeo) {
      final position = await _foursquareRepo.getCurrentLocation();

      if (position != null && event.groupId.isNotEmpty) {
        final result = await _groupRepo.sendEmergency(position, event.groupId);
        if(result){
          toast(message.msg_success);
        }
        else{
          toast(message.errorSystem);
        }
      } else {
        toast(message.msg_location_required);
      }
    } else {
      toast(message.msg_location_required);
    }
    emit(state.copyWith(status: PageState.success));
  }
}
