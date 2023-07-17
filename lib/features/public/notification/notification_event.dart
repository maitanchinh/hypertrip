part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class FetchNotificationList extends NotificationEvent {
  const FetchNotificationList();

  @override
  List<Object> get props => [];
}

class ItemNotificationClick extends NotificationEvent {
  final FirebaseMessage item;
  const ItemNotificationClick({required this.item});

  @override
  List<Object> get props => [item];
}

class OnClearPageCommand extends NotificationEvent {
  const OnClearPageCommand();

  @override
  List<Object> get props => [];
}

class NotifyReadAll extends NotificationEvent {
  const NotifyReadAll();

  @override
  List<Object> get props => [];
}