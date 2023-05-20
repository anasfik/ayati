import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../logic/already_read/already_readed_ayahs_cubit.dart';

class FAB extends StatelessWidget {
  const FAB({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AlreadyReadedAyahsCubit>();

    return FloatingActionButton(
      onPressed: () {
        cubit.executeSearch();
      },
      child: const Icon(FlutterRemix.search_2_line),
    );
  }
}
