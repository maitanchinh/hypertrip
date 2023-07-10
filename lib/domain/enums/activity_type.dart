// ignore_for_file: constant_identifier_names

enum ActivityType {
  All("All"),
  Attendance("Attendance"),
  CheckIn("Check-in"),
  Custom("Custom");

  final String name;
  const ActivityType(this.name);
}
