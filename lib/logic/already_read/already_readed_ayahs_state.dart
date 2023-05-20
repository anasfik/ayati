// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'already_readed_ayahs_cubit.dart';

class AlreadyReadedAyahsState extends Equatable {
  final List<Ayah> alreadyReadAyahs;
  final List<Ayah> searchedAyahs;

  const AlreadyReadedAyahsState({
    this.alreadyReadAyahs = const [],
    this.searchedAyahs = const [],
  });

  @override
  List<Object?> get props => [
        alreadyReadAyahs,
        searchedAyahs,
      ];

  AlreadyReadedAyahsState copyWith({
    List<Ayah>? alreadyReadAyahs,
    List<Ayah>? searchedAyahs,
  }) {
    return AlreadyReadedAyahsState(
      alreadyReadAyahs: alreadyReadAyahs ?? this.alreadyReadAyahs,
      searchedAyahs: searchedAyahs ?? this.searchedAyahs,
    );
  }
}

class AlreadyReadedAyahsInitial extends AlreadyReadedAyahsState {}
