// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ayat_fetcher_cubit.dart';

@immutable
class AyatFetcherState extends Equatable {
  final String? error;

  const AyatFetcherState({
    this.error,
  });

  @override
  List<Object?> get props => [
        error,
      ];

  AyatFetcherState copyWith({
    String? error,
  }) {
    return AyatFetcherState(
      error: error ?? this.error,
    );
  }
}

class AyatFetcherInitial extends AyatFetcherState {}
