import 'package:ayat_notifications/data/local/local.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/ayah.dart';

part 'already_readed_ayahs_state.dart';

class AlreadyReadedAyahsCubit extends Cubit<AlreadyReadedAyahsState> {
  TextEditingController? controller;

  AlreadyReadedAyahsCubit() : super(AlreadyReadedAyahsInitial()) {
    controller = TextEditingController();
    _init();
  }

  @override
  Future<void> close() {
    controller!.dispose();

    return super.close();
  }

  void _init() {
    try {
      final ayahs = LocalDatabase.instance.ayahsBeforeCurrentOne();
      emit(state.copyWith(alreadyReadAyahs: ayahs));
    } catch (e) {
      emit(state.copyWith(alreadyReadAyahs: []));
    }
  }

  void executeSearch() {}
}
