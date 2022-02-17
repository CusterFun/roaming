/// 首字母转大写
String toUpperCase({String? str, String? name}) {
  if (str == null) {
    if (name != null) {
      return name;
    }
    return '';
  }
  if (str.length > 1) {
    return str.replaceRange(0, 1, str[0].toUpperCase());
  }
  return '';
}

/// 首字母转小写
String toLowerCase({String? str, String? name}) {
  if (str == null) {
    if (name != null) return name;
    return '';
  }
  if (str.length > 1) {
    return str.replaceRange(0, 1, str[0].toLowerCase());
  }
  return '';
}

/// 驼峰转换下划线
String toSQLLine(String str) {
  return str.replaceAllMapped(RegExp(r'[A-Z]'), (Match m) {
    return '_' + m.group(0)!.toLowerCase();
  });
}

/// 下划线转换驼峰
String toHump(String str) {
  return str.replaceAllMapped(RegExp(r'\_(\w)'), (Match m) {
    return capitalize(m.group(0)!.substring(1));
  });
}

String capitalize(String? k) {
  if (k != null && k.isNotEmpty) {
    return k[0].toUpperCase() + k.substring(1);
  }
  return k ?? '';
}
