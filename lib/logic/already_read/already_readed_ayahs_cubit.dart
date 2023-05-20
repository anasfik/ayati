import 'package:ayat_notifications/data/local/local.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/ayah.dart';

part 'already_readed_ayahs_state.dart';

class AlreadyReadedAyahsCubit extends Cubit<AlreadyReadedAyahsState> {
  AlreadyReadedAyahsCubit() : super(AlreadyReadedAyahsInitial()) {
    _init();
  }

  void _init() {
    try {
      final ayahs = LocalDatabase.instance.ayahsBeforeCurrentOne();
      emit(state.copyWith(alreadyReadAyahs: ayahs));
    } catch (e) {
      emit(state.copyWith(alreadyReadAyahs: []));
    }
  }
}
