// ignore_for_file: constant_identifier_names

enum ActivityType {
  // All("All"),
  // Attendance("Attendance"),
  // CheckIn("Check-in"),
  // Custom("Custom");
  All("All", "All"),
  Attendance("Attendance", "Attendance"),
  CheckIn("CheckIn", "Check-in"),
  Custom("Custom", "Custom");

  final String name;
  final String label;
  const ActivityType(this.name, this.label);
}
