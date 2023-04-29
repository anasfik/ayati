import 'package:ayat_notifications/data/local/local.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../data/remote/remote.dart';

part 'ayat_fetcher_state.dart';

class AyatFetcherCubit extends Cubit<AyatFetcherState> {
  AyatFetcherCubit() : super(AyatFetcherInitial()) {
    _handleFetching();
  }

  Future<void> _handleFetching() async {
    try {
      final quranResponse = await RemoteSource.instance.fetchAyat();
      LocalDatabase.instance.saveQuranResponse(quranResponse);
    } catch (e) {
      emit(
        state.copyWith(
          error: kDebugMode ? e.toString() : "Something went wrong..",
        ),
      );
    }
  }
}
