part of 'chat_detail_bloc.dart';

class ChatDetailState extends Equatable {
  final PageState status;
  final List<FirestoreMessage> messages;
  final String message;
  final String error;
  final ChatUser? currentUser;
  final List<ChatUser> members;
  final bool isOpenMap;
  final bool isPermissionGeolocation;
  final Position? position;
  final bool isCanDrag;
  final List<String> deviceTokens;

  const ChatDetailState({
    required this.status,
    required this.error,
    required this.messages,
    required this.message,
    this.currentUser,
    required this.members,
    this.isOpenMap = false,
    this.isPermissionGeolocation = false,
    this.position,
    this.isCanDrag = false,
    required this.deviceTokens,
  });

  ChatDetailState copyWith({
    PageState? status,
    String? error,
    List<FirestoreMessage>? messages,
    String? message,
    ChatUser? currentUser,
    List<ChatUser>? members,
    bool? isOpenMap,
    bool? isPermissionGeolocation,
    Position? position,
    bool? isCanDrag,
    List<String>? deviceTokens,
  }) {
    return ChatDetailState(
      status: status ?? this.status,
      error: error ?? this.error,
      messages: messages ?? this.messages,
      message: message ?? this.message,
      members: members ?? this.members,
      currentUser: currentUser ?? this.currentUser,
      isOpenMap: isOpenMap ?? this.isOpenMap,
      isPermissionGeolocation: isPermissionGeolocation ?? this.isPermissionGeolocation,
      position: position ?? this.position,
      isCanDrag: isCanDrag ?? this.isCanDrag,
      deviceTokens: deviceTokens ?? this.deviceTokens,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        messages,
        message,
        currentUser,
        isOpenMap,
        isPermissionGeolocation,
        position,
        isCanDrag,
        deviceTokens
      ];
}
