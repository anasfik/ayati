import 'package:ayat_notifications/data/local/local.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../data/remote/remote.dart';

part 'ayat_fetcher_state.dart';

class AyatFetcherCubit extends Cubit<AyatFetcherState> {
  AyatFetcherCubit() : super(AyatFetcherInitial());

  Future<void> handleFetching() async {
    final isSurahsAlreadySaved = LocalDatabase.instance.isSurahsAlreadySaved();
    if (isSurahsAlreadySaved) {
      emit(state.copyWith(areAyahsSavedForLaterUse: true));
      return;
    }

    try {
      emit(state.copyWith(isLoadingForAyat: true));
      final quranResponse = await RemoteSource.instance.fetchAyat();
      await LocalDatabase.instance.saveQuranResponse(quranResponse);
      emit(state.copyWith(areAyahsSavedForLaterUse: true));
    } catch (e) {
      emit(
        state.copyWith(
          error: kDebugMode ? e.toString() : "Something went wrong..",
        ),
      );
    } finally {
      emit(state.copyWith(isLoadingForAyat: false));
    }
  }
}
