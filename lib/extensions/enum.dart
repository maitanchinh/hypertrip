extension EnumString on Enum {
  bool compareEnumAndString(String value) =>
      toString().toLowerCase() == value.toLowerCase();
}
