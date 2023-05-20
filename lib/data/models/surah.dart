// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  const Surah({
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

  @override
  List<Object?> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        ayahs,
      ];

  Surah copyWith({
    int? number,
    String? name,
    String? englishName,
    String? englishNameTranslation,
    RevelationType? revelationType,
    List<Ayah>? ayahs,
  }) {
    return Surah(
      number: number ?? this.number,
      name: name ?? this.name,
      englishName: englishName ?? this.englishName,
      englishNameTranslation:
          englishNameTranslation ?? this.englishNameTranslation,
      revelationType: revelationType ?? this.revelationType,
      ayahs: ayahs ?? this.ayahs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationTypeValues.reverse[revelationType]!,
      'ayahs': ayahs.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  bool matchesSearch(String searchQuery) {
    final query = searchQuery;

    final doesNameMatches = name.toLowerCase().contains(query.toLowerCase());

    final doesEnglishName =
        englishName.toLowerCase().contains(query.toLowerCase());

    return doesNameMatches || doesEnglishName;
  }

  factory Surah.fromJson(String source) =>
      Surah.fromMap(json.decode(source) as Map<String, dynamic>);
}
