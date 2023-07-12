part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class FetchGroupChat extends ChatEvent {
  final String? userid;
  final String role;
  const FetchGroupChat(this.userid, this.role);

  @override
  List<Object> get props => [userid ?? ''];
}

class SearchGroupEvent extends ChatEvent {
  final String key;
  const SearchGroupEvent(this.key);

  @override
  List<Object> get props => [key];
}

class FetchLastedMessage extends ChatEvent {
  final String groupId;
  const FetchLastedMessage(this.groupId);

  @override
  List<Object> get props => [groupId];
}
