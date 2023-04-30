import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'edition.dart';
import 'surah.dart';

QuranResponse quranResponseFromMap(String str) =>
    QuranResponse.fromMap(json.decode(str));

class QuranResponse {
  final int code;
  final String status;
  final Data data;

  QuranResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QuranResponse.fromMap(Map<String, dynamic> json) => QuranResponse(
        code: json["code"],
        status: json["status"],
        data: Data.fromMap(json["data"]),
      );
}

class Data {
  final List<Surah> surahs;
  final Edition edition;

  Data({
    required this.surahs,
    required this.edition,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        surahs: List<Surah>.from(json["surahs"].map((x) => Surah.fromMap(x))),
        edition: Edition.fromMap(json["edition"]),
      );
}
