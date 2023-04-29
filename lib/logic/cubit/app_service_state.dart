part of 'app_service_cubit.dart';

abstract class AppServiceState extends Equatable {
  const AppServiceState();

  @override
  List<Object> get props => [];
}

class AppServiceInitial extends AppServiceState {}
