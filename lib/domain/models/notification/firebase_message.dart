import 'package:hypertrip/utils/app_assets.dart';

class FirebaseMessage {
  String id;
  String title;
  String payload;
  FirebaseMessageType type;
  DateTime? timestamp;
  bool isRead;
  String imageUrl;
  String tripId;

  FirebaseMessage({
    this.id = "0",
    this.title = '',
    this.payload = '',
    this.type = FirebaseMessageType.AttendanceActivity,
    this.timestamp,
    this.isRead = true,
    this.imageUrl = '',
    this.tripId = '',
  });

  FirebaseMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '0',
        title = json['title'] ?? '',
        payload = json['payload'] ?? '',
        type = _parseMessageType(json['type']),
        timestamp = json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
        isRead = json['isRead'] ?? true,
        imageUrl = json['imageUrl'] ?? '',
        tripId = json['tripId'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'payload': payload,
        'type': _getMessageTypeString(type),
        'timestamp': timestamp?.toIso8601String(),
        'isRead': isRead,
        'imageUrl': imageUrl,
        'tripId': tripId,
      };

  FirebaseMessage copyWith({
    String? id,
    String? title,
    String? payload,
    FirebaseMessageType? type,
    DateTime? timestamp,
    bool? isRead,
    String? imageUrl,
    String? tripId,
  }) {
    return FirebaseMessage(
      id: id ?? this.id,
      title: title ?? this.title,
      payload: payload ?? this.payload,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
      tripId: tripId ?? this.tripId,
    );
  }

  static FirebaseMessageType _parseMessageType(String value) {
    switch (value) {
      case 'AttendanceActivity':
        return FirebaseMessageType.AttendanceActivity;
      case 'WeatherAlert':
        return FirebaseMessageType.WeatherAlert;
      case 'Emergency':
        return FirebaseMessageType.Emergency;
      default:
        return FirebaseMessageType.AttendanceActivity;
    }
  }

  static String _getMessageTypeString(FirebaseMessageType type) {
    switch (type) {
      case FirebaseMessageType.AttendanceActivity:
        return 'AttendanceActivity';
      case FirebaseMessageType.WeatherAlert:
        return 'WeatherAlert';
      case FirebaseMessageType.Emergency:
        return 'Emergency';
      default:
        return 'AttendanceActivity';
    }
  }
}

enum FirebaseMessageType {
  AttendanceActivity,
  WeatherAlert,
  Emergency;

  String get image {
    switch (this) {
      case FirebaseMessageType.AttendanceActivity:
        return AppAssets.icons_attendance_svg;
      // case FirebaseMessageType.TourStarted:
      //   return AppAssets.icons_finish_flag_svg;
      // case FirebaseMessageType.CheckInAcitvity:
      //   return AppAssets.icons_destination_svg;
      default:
        return AppAssets.icons_bell_color_svg;
    }
  }
}
