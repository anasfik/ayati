import 'package:ayat_notifications/data/local/local.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/ayah.dart';

part 'already_readed_ayahs_state.dart';

class AlreadyReadedAyahsCubit extends Cubit<AlreadyReadedAyahsState> {
  TextEditingController? searchController;

  AlreadyReadedAyahsCubit() : super(AlreadyReadedAyahsInitial()) {
    searchController = TextEditingController();
    _init();
  }

  @override
  Future<void> close() {
    searchController!.dispose();

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

  void executeSearch() {
    final controller = searchController;
    if (controller == null || controller.text.isEmpty) {
      return;
    }

    final searchQuery = controller.text;

    final ayahsThatLatchSearchQuery = state.alreadyReadAyahs
        .where((ayah) => ayah.matchesSearchQuery(searchQuery))
        .toList();

    emit(state.copyWith(searchedAyahs: ayahsThatLatchSearchQuery));
  }

  void resetSearch() {
    searchController!.clear();
    emit(state.copyWith(searchedAyahs: const <Ayah>[]));
  }
}
