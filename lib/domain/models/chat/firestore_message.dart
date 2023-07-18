import 'package:chatview/chatview.dart';


class FirestoreMessage {
  String? senderId;
  MessageType type;
  String content;
  DateTime timestamp;

  FirestoreMessage({
    this.senderId,
    required this.type,
    required this.content,
    required this.timestamp,
  });

  factory FirestoreMessage.fromJson(Map<String, dynamic> json) {
    return FirestoreMessage(
      senderId: json['SenderId'],
      type: _enumFromJson(json['Type']),
      content: json['Content'],
      timestamp: DateTime.parse(json['Timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SenderId': senderId,
      'Type': _enumToJson(type),
      'Content': content,
      'Timestamp': timestamp.toIso8601String(),
    };
  }

  static MessageType _enumFromJson(String value) {
    return MessageType.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static String _enumToJson(MessageType value) {
    return value.toString().split('.').last;
  }

  Message toMessage() {
    return Message(
      id: senderId ?? '',
      sendBy: senderId ?? '',
      message: content,
      createdAt: timestamp,
    );
  }
}