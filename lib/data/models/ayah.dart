// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:ayat_notifications/data/models/surah.dart';

part 'ayah.g.dart';

@HiveType(typeId: 1)
class Ayah extends Equatable {
  @HiveField(0)
  final int number;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final int numberInSurah;

  @HiveField(3)
  final int juz;

  @HiveField(4)
  final int manzil;

  @HiveField(5)
  final int page;

  @HiveField(6)
  final int ruku;

  @HiveField(7)
  final int hizbQuarter;

  @HiveField(8)
  final dynamic sajda;

  @HiveField(9)
  final Surah? surah;

  const Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    this.surah,
  });

  factory Ayah.fromMap(Map<String, dynamic> json) => Ayah(
        number: json["number"],
        text: json["text"],
        numberInSurah: json["numberInSurah"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"],
      );

  @override
  List<Object?> get props => [
        number,
        text,
        numberInSurah,
        juz,
        manzil,
        page,
        ruku,
        hizbQuarter,
        sajda,
        surah,
      ];

  String customNotificationText() {
    return '${number.toString()} of 6236 in the Quran, Hizb $hizbQuarter';
  }

  Ayah copyWith({
    int? number,
    String? text,
    int? numberInSurah,
    int? juz,
    int? manzil,
    int? page,
    int? ruku,
    int? hizbQuarter,
    dynamic? sajda,
    Surah? surah,
  }) {
    return Ayah(
      number: number ?? this.number,
      text: text ?? this.text,
      numberInSurah: numberInSurah ?? this.numberInSurah,
      juz: juz ?? this.juz,
      manzil: manzil ?? this.manzil,
      page: page ?? this.page,
      ruku: ruku ?? this.ruku,
      hizbQuarter: hizbQuarter ?? this.hizbQuarter,
      sajda: sajda ?? this.sajda,
      surah: surah ?? this.surah,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
      'surah': surah?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Ayah.fromJson(String source) =>
      Ayah.fromMap(json.decode(source) as Map<String, dynamic>);

  bool matchesSearchQuery(String searchQuery) {
    final query = searchQuery;

    final doesTextContainsQuery =
        text.toLowerCase().contains(query.toLowerCase());

    final doesItMatchNumber =
        number.toString().toLowerCase().contains(query.toLowerCase());

    final doesSurahSearchMatchesQuery = surah?.matchesSearch(query) ?? false;

    return doesTextContainsQuery ||
        doesSurahSearchMatchesQuery ||
        doesItMatchNumber;
  }
}
