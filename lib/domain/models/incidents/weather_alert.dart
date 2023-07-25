class WeatherAlert {
  String id;
  String tripId;
  String headline;
  String severity;
  String areas;
  String certainty;
  String event;
  String note;
  DateTime? effective; // Nullable DateTime
  DateTime? expires; // Nullable DateTime
  String description;
  String instruction;

  WeatherAlert({
    this.id = '',
    this.tripId = '',
    this.headline = '',
    this.severity = '',
    this.areas = '',
    this.certainty = '',
    this.event = '',
    this.note = '',
    this.effective,
    this.expires,
    this.description = '',
    this.instruction = '',
  });

  // Factory constructor to create a WeatherAlert object from a JSON map
  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      id: json['id'],
      tripId: json['tripId'],
      headline: json['headline'],
      severity: json['severity'],
      areas: json['areas'],
      certainty: json['certainty'],
      event: json['event'],
      note: json['note'],
      effective: json['effective'] != null
          ? DateTime.parse(json['effective'])
          : null,
      expires: json['expires'] != null
          ? DateTime.parse(json['expires'])
          : null,
      description: json['description'],
      instruction: json['instruction'],
    );
  }

  // Convert the WeatherAlert object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'headline': headline,
      'severity': severity,
      'areas': areas,
      'certainty': certainty,
      'event': event,
      'note': note,
      'effective': effective != null ? effective!.toIso8601String() : null,
      'expires': expires != null ? expires!.toIso8601String() : null,
      'description': description,
      'instruction': instruction,
    };
  }
}
