import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hypertrip/domain/models/notification/firebase_message.dart';
import 'package:hypertrip/domain/repositories/notification_repo.dart';
import 'package:hypertrip/utils/constant.dart';
import 'package:hypertrip/utils/page_command.dart';
import 'package:hypertrip/utils/page_states.dart';
import 'package:nb_utils/nb_utils.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo _notificationRepo;

  NotificationBloc(this._notificationRepo)
      : super(const NotificationState(
          error: '',
          status: PageState.loading,
          notifications: [],
        )) {
    on<FetchNotificationList>(_fetchNotificationList);
    on<ItemNotificationClick>(_itemNotificationClick);
    on<NotifyReadAll>(_notifyReadAll);
    on<OnClearPageCommand>(
        (event, emit) => emit(state.copyWith(pageCommand: null)));
  }

  FutureOr<void> _fetchNotificationList(event, Emitter emit) async {
    try {
      final response = await _notificationRepo.fetchNotificationList();

      emit(state.copyWith(notifications: response, status: PageState.success));

    } catch (ex) {
      emit(state.copyWith(status: PageState.failure, error: ex.toString()));
    }
  }

  FutureOr<void> _itemNotificationClick(
      ItemNotificationClick event, Emitter<NotificationState> emit) async {
    String page = '';
    switch (event.item.type) {
      case FirebaseMessageType.AttendanceActivity:
        // page = Routers.CURRRENT_TOUR_PAGE;
        break;
      case FirebaseMessageType.TourStarted:
        // TODO: Handle this case.
        break;
    }

    // Check if the notification exists
    int index = state.notifications
        .indexWhere((notification) => notification.id == event.item.id);
    if (index != -1) {
      List<FirebaseMessage> notificationsClone = List.from(state.notifications);
      notificationsClone[index] =
          notificationsClone[index].copyWith(isRead: true);

      emit(state.copyWith(
          notifications: notificationsClone,
          status: PageState.success,
          pageCommand: PageCommandNavigatorPage(page: page, argument: '')));

      // Read the notification
      final result = await _notificationRepo.readNotification(event.item.id);

      final value = getIntAsync(AppConstant.keyCountNotify);
      setValue(AppConstant.keyCountNotify, value - 1);
    } else {
      // If the notification does not exist, throw an error
      emit(state.copyWith(
          status: PageState.failure, error: 'Notification not found'));
    }
  }

  FutureOr<void> _notifyReadAll(
      NotifyReadAll event, Emitter<NotificationState> emit) async {
    try {
      final result = await _notificationRepo.readAllNotifications();

      final notificationsClone = state.notifications.map((notification) {
        return notification.copyWith(isRead: true);
      }).toList();

      // Reset count notify
      setValue(AppConstant.keyCountNotify, 0);

      emit(state.copyWith(
          notifications: notificationsClone, status: PageState.success));
    } catch (ex) {
      emit(state.copyWith(status: PageState.failure, error: ex.toString()));
    }
  }
}
