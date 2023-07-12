class WeatherAlert {
  String senderName;
  String event;
  int start;
  int end;
  String description;
  String severity;
  List<String> tags;

  WeatherAlert({
    this.senderName = '',
    this.event = '',
    this.start = 0,
    this.end = 0,
    this.description = '',
    this.severity = '',
    this.tags = const [],
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'] ?? '',
      event: json['event'] ?? '',
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
      description: json['description'] ?? '',
      severity: json['severity'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'sender_name': senderName,
    'event': event,
    'start': start,
    'end': end,
    'description': description,
    'severity': severity,
    'tags': tags,
  };
}