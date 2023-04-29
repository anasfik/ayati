import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/app_service_cubit.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          context.read<AppServiceCubit>().startService();
        },
        child: const Text('Start'),
      ),
    );
  }
}
