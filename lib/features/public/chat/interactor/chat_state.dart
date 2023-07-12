part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final PageState status;
  final List<AssignGroupResponse> groupChat;
  final String error;
  final FirestoreMessage? message;

  const ChatState({required this.status, required this.error, required this.groupChat, this.message});

  ChatState copyWith({
    PageState? status,
    List<AssignGroupResponse>? groupChat,
    String? error,
    FirestoreMessage? message,
  }) {
    return ChatState(
      status: status ?? this.status,
      groupChat: groupChat ?? this.groupChat,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [error, groupChat, message, status];
}
