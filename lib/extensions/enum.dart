extension EnumString on Enum {
  bool compareWithString(String? value) =>
      name.toLowerCase() == (value ?? "").toLowerCase();
}
