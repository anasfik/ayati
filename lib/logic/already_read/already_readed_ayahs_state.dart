// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'already_readed_ayahs_cubit.dart';

class AlreadyReadedAyahsState extends Equatable {
  final List<Ayah> alreadyReadAyahs;

  const AlreadyReadedAyahsState({
    this.alreadyReadAyahs = const [],
  });

  @override
  List<Object?> get props => [alreadyReadAyahs];

  AlreadyReadedAyahsState copyWith({
    List<Ayah>? alreadyReadAyahs,
  }) {
    return AlreadyReadedAyahsState(
      alreadyReadAyahs: alreadyReadAyahs ?? this.alreadyReadAyahs,
    );
  }
}

class AlreadyReadedAyahsInitial extends AlreadyReadedAyahsState {}
