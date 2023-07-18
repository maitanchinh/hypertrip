part of 'chat_detail_bloc.dart';

abstract class ChatDetailEvent extends Equatable {
  const ChatDetailEvent();
}

class FetchMessageGroupChat extends ChatDetailEvent {
  final String groupId;
  const FetchMessageGroupChat(this.groupId);

  @override
  List<Object> get props => [];
}

class GetMembersTourGroup extends ChatDetailEvent {
  final String groupId;
  final String userId;

  const GetMembersTourGroup(this.groupId, this.userId);

  @override
  List<Object> get props => [groupId, userId];
}

class SendMessageGroupChat extends ChatDetailEvent {
  final String message;
  final MessageType type;
  final String groupId;
  final String userId;
  final String groupName;
  const SendMessageGroupChat({
    required this.message,
    required this.groupId,
    required this.userId,
    required this.type,
    required this.groupName,
  });

  @override
  List<Object> get props => [];
}

class GetProfileUser extends ChatDetailEvent {
  final String userId;
  const GetProfileUser(this.userId);

  @override
  List<Object> get props => [];
}

class StatusMapEvent extends ChatDetailEvent {
  final bool isOpenMap;
  const StatusMapEvent(this.isOpenMap);

  @override
  List<Object> get props => [isOpenMap];
}

class RequestPermissionLocationEvent extends ChatDetailEvent {
  const RequestPermissionLocationEvent();

  @override
  List<Object> get props => [];
}

class DragPanelEvent extends ChatDetailEvent {
  final bool isTap;
  const DragPanelEvent(this.isTap);

  @override
  List<Object> get props => [isTap];
}

class GetAllTokenFCMDeviceGroup extends ChatDetailEvent {
  const GetAllTokenFCMDeviceGroup();

  @override
  List<Object> get props => [];
}
