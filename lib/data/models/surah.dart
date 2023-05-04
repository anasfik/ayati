import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'ayah.dart';
import 'type.dart';

part 'surah.g.dart';

@HiveType(typeId: 0)
class Surah extends Equatable {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String englishName;
  @HiveField(3)
  final String englishNameTranslation;
  @HiveField(4)
  final RevelationType revelationType;
  @HiveField(5)
  final List<Ayah> ayahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: revelationTypeValues.map[json["revelationType"]]!,
        ayahs: List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "revelationType": revelationTypeValues.reverse[revelationType],
        "ayahs": List<dynamic>.from(ayahs.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        ayahs,
      ];
}
