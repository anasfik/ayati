import 'package:ayat_notifications/presentation/general/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/app_service/app_service_cubit.dart';

class ErrorDuringFetch extends StatelessWidget {
  const ErrorDuringFetch({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppServiceCubit>();

    return Column(
      children: <Widget>[
        const Text('Error during fetching ayahs'),
        const SizedBox(height: 10),
        AyatiButton(
          onTap: () {
            cubit.fetcherCubit.handleFetching();
          },
          text: 'Retry',
        ),
      ],
    );
  }
}
