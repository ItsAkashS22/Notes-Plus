Map<String, Object?> convertBoolToBits(Map<String, Object?> map) {
  for (var key in map.keys) {
    Object? value = map[key];
    if (value is bool) {
      map[key] = value ? 1 : 0;
    }
  }
  return map;
}
