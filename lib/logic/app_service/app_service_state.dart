// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_service_cubit.dart';

class AppServiceState extends Equatable {
  final AyatFetcherState fetcherState;
  const AppServiceState({
    required this.fetcherState,
  });

  @override
  List<Object> get props => [fetcherState];

  AppServiceState copyWith({
    AyatFetcherState? fetcherState,
  }) {
    return AppServiceState(
      fetcherState: fetcherState ?? this.fetcherState,
    );
  }
}

class AppServiceInitial extends AppServiceState {
  const AppServiceInitial({required super.fetcherState});
}
