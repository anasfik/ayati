import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBox extends StatelessWidget {
  const TodoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppServiceCubit, AppServiceState>(
      builder: (context, state) {
        if (state.fetcherState.areAyahsSavedForLaterUse) {
          return SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Info",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Icon(
                    Icons.info_outline,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "For the very first app use, you will need to load the data from the internet that it will be used for the app service to work.",
              ),
            ],
          ),
        );
      },
    );
  }
}