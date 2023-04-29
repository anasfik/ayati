import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_service_state.dart';

class AppServiceCubit extends Cubit<AppServiceState> {
  AppServiceCubit() : super(AppServiceInitial());

  void startService() {}
}
