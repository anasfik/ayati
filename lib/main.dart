import 'package:ayat_notifications/logic/cubit/ayat_fetcher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AyatFetcherCubit>(
        create: (context) => AyatFetcherCubit(),
        child: Container(),
      ),
    );
  }
}
