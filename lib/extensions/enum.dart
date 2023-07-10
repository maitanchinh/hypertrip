extension EnumString on Enum {
  bool compareEnumAndString(String value) =>
      name.toLowerCase() == value.toLowerCase();
}
