// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_service_cubit.dart';

class AppServiceState extends Equatable {
  final AyatFetcherState fetcherState;
  final BottomBarItem? selectedBottomBarItem;

  const AppServiceState({
    required this.fetcherState,
    this.selectedBottomBarItem,
  });

  @override
  List<Object?> get props => [fetcherState, selectedBottomBarItem];

  AppServiceState copyWith({
    AyatFetcherState? fetcherState,
    BottomBarItem? selectedBottomBarItem,
  }) {
    return AppServiceState(
      selectedBottomBarItem:
          selectedBottomBarItem ?? this.selectedBottomBarItem,
      fetcherState: fetcherState ?? this.fetcherState,
    );
  }
}

class AppServiceInitial extends AppServiceState {
  const AppServiceInitial({
    required super.fetcherState,
  });
}
