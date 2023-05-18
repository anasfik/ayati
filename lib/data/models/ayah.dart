import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
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

  Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
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

  Map<String, dynamic> toMap() => {
        "number": number,
        "text": text,
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
      };

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
      ];

  String customNotificationText() {
    return '${number.toString()} of 6236 in the Quran, Hizb $hizbQuarter';
  }
}
