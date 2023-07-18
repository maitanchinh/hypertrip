part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final PageState status;
  final List<FirebaseMessage> notifications;
  final String error;
  final PageCommand? pageCommand;

  const NotificationState({
    required this.status,
    required this.error,
    required this.notifications,
    this.pageCommand,
  });

  NotificationState copyWith({
    PageState? status,
    List<FirebaseMessage>? notifications,
    String? error,
    PageCommand? pageCommand,
  }) {
    return NotificationState(
      status: status ?? this.status,
      error: error ?? this.error,
      notifications: notifications ?? this.notifications,
      pageCommand: pageCommand ?? this.pageCommand,
    );
  }

  @override
  List<Object?> get props => [status, error, notifications, pageCommand];
}
