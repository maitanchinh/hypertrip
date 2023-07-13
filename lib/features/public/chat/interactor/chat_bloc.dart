import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/chat/firestore_message.dart';
import 'package:hypertrip/domain/models/group/assign_group_response.dart';
import 'package:hypertrip/domain/repositories/firestore_repository.dart';
import 'package:hypertrip/domain/repositories/group_repo.dart';
import 'package:hypertrip/domain/repositories/tour_repo.dart';
import 'package:hypertrip/utils/page_states.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final TourRepo _tourGuideRepository;
  final GroupRepo _travelerRepository;
  final FirestoreRepository _firestoreRepository;

  List<AssignGroupResponse> _originList = [];

  ChatBloc(this._tourGuideRepository, this._travelerRepository, this._firestoreRepository)
      : super(const ChatState(groupChat: [], error: '', status: PageState.loading)) {
    on<FetchGroupChat>(_fetchGroupChat);
    on<SearchGroupEvent>(_searchGroupEvent);
    on<FetchLastedMessage>(_fetchLastedMessage);
  }

  Future<void> _fetchGroupChat(FetchGroupChat event, Emitter<ChatState> emit) async {
    try {
      if (event.userid != null && event.userid!.isNotEmpty) {
        List<AssignGroupResponse> result = [];
        if (event.role == 'TourGuide') {
          result = (await _tourGuideRepository.getAllAssignedGroups(event.userid!));
        } else {
          result.add(await _travelerRepository.getAllCurrentGroups(event.userid!));
          result.addAll(await _travelerRepository.getAllJoinedGroups(event.userid!));
        }
        result.sort((b, a) {
          if (a.createdAt != null && b.createdAt != null) {
            return a.createdAt!.compareTo(b.createdAt!);
          } else if (a.createdAt == null && b.createdAt == null) {
            return 0;
          } else if (a.createdAt != null) {
            return -1;
          } else {
            return 1;
          }
        });

        _originList = result;
        emit(state.copyWith(groupChat: result));
      }
    } catch (ex) {
      emit(state.copyWith(status: PageState.failure, error: ex.toString()));
    }
  }

  Future<void> _searchGroupEvent(SearchGroupEvent event, Emitter<ChatState> emit) async {
    try {
      final lstAfterSearch = event.key.isNotEmpty
          ? _originList.where((assignGroupResponse) {
              if (assignGroupResponse.groupName.toLowerCase().contains(event.key.toLowerCase())) {
                return true;
              }

              if ((assignGroupResponse.trip?.code!
                      .toLowerCase()
                      .contains(event.key.toLowerCase()) ??
                  false)) return true;

              if ((assignGroupResponse.trip?.tour?.destination!
                      .toLowerCase()
                      .contains(event.key.toLowerCase()) ??
                  false)) return true;
              if ((assignGroupResponse.trip?.tour?.description!
                      .toLowerCase()
                      .contains(event.key.toLowerCase()) ??
                  false)) return true;

              return false;
            }).toList()
          : _originList;
      emit(state.copyWith(groupChat: lstAfterSearch));
    } catch (ex) {
      emit(state.copyWith(status: PageState.failure, error: ex.toString()));
    }
  }

  FutureOr<void> _fetchLastedMessage(FetchLastedMessage event, Emitter<ChatState> emit) async {
    await emit.forEach<FirestoreMessage>(
      _firestoreRepository.fetchLastedMessage(event.groupId),
      onError: (error, StackTrace stackTrace) {
        return state;
      },
      onData: (FirestoreMessage result) {
        return state.copyWith(
          message: result,
        );
      },
    );
  }
}
