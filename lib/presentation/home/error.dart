import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../logic/app_service/app_service_cubit.dart';
import '../../utils/colors.dart';

class ErrorDuringFetch extends StatelessWidget {
  const ErrorDuringFetch({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppServiceCubit>();

    return GestureDetector(
      onTap: () {
        cubit.fetcherCubit.handleFetching();
      },
      child: Row(
        children: const <Widget>[
          AutoSizeText(
            'Error during fetching ayahs',
            maxLines: 1,
          ),
          SizedBox(width: 10.0),
          Icon(
            FlutterRemix.restart_line,
            size: 24,
            color: AppColors.green,
          )
        ],
      ),
    );
  }
}
