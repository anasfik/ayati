part of 'ayat_fetcher_cubit.dart';

@immutable
class AyatFetcherState extends Equatable {
  final bool isLoadingForAyat;
  final bool areAyahsSavedForLaterUse;
  final String? error;

  const AyatFetcherState({
    this.error,
    this.isLoadingForAyat = false,
    this.areAyahsSavedForLaterUse = false,
  });

  @override
  List<Object?> get props => [
        error,
        isLoadingForAyat,
        areAyahsSavedForLaterUse,
      ];

  AyatFetcherState copyWith({
    String? error,
    bool? isLoadingForAyat,
    bool? areAyahsSavedForLaterUse,
  }) {
    return AyatFetcherState(
      error: error ?? this.error,
      isLoadingForAyat: isLoadingForAyat ?? this.isLoadingForAyat,
      areAyahsSavedForLaterUse:
          areAyahsSavedForLaterUse ?? this.areAyahsSavedForLaterUse,
    );
  }
}

class AyatFetcherInitial extends AyatFetcherState {}
