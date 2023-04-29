import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ayat_fetcher_state.dart';

class AyatFetcherCubit extends Cubit<AyatFetcherState> {
  AyatFetcherCubit() : super(AyatFetcherInitial());
}
