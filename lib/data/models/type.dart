import 'package:hive/hive.dart';

part 'type.g.dart';

@HiveType(typeId: 2)
enum RevelationType {
  @HiveField(0)
  MECCAN,

  @HiveField(1)
  MEDINAN,
}

final revelationTypeValues = EnumValues(
    {"Meccan": RevelationType.MECCAN, "Medinan": RevelationType.MEDINAN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
