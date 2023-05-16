import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadAyahsButton extends StatelessWidget {
  const LoadAyahsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppServiceCubit>();
    return ElevatedButton(
      onPressed: () {
        cubit.fetcherCubit.handleFetching();
      },
      child: const Text("Load Ayahs"),
    );
  }
}
