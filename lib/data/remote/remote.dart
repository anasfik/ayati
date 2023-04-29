import 'package:flutter/foundation.dart';

import '../../utils/exeptions.dart';
import '../models/quran_response.dart';
import 'base/base.dart';
import 'package:http/http.dart' as http;

class RemoteSource implements RemoteSourceBase {
  static RemoteSource get instance => _instance;

  @override
  Future<QuranResponse> fetchAyat() {
    return compute(_fetchAyat, null);
  }

  Future<QuranResponse> _fetchAyat(dynamic _) async {
    try {
      final response = await http.get(
        Uri.parse('http://api.alquran.cloud/v1/quran/ar.asad'),
      );
      if (response.isOk) {
        return quranResponseFromMap(response.body);
      } else {
        throw FetchException('Failed to load ayat');
      }
    } catch (e) {
      throw FetchException('Failed to load ayat');
    }
  }

  static final _instance = RemoteSource._();
  RemoteSource._();
}

extension on http.Response {
  bool get isOk => statusCode >= 200 && statusCode < 300;
}
