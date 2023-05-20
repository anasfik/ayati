import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/already_read/already_readed_ayahs_cubit.dart';

class AlreadyReadedAyahs extends StatelessWidget {
  const AlreadyReadedAyahs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlreadyReadedAyahsCubit>(
      create: (_) => AlreadyReadedAyahsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AlreadyReadedAyahsCubit>();

          return Scaffold(
            appBar: AppBar(),
            // floatingActionButton: Floating,
            body: Directionality(
              textDirection: TextDirection.rtl,
              child:
                  BlocBuilder<AlreadyReadedAyahsCubit, AlreadyReadedAyahsState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.alreadyReadAyahs.length,
                    itemBuilder: (context, index) {
                      final ayah = state.alreadyReadAyahs[index];
                      return ListTile(
                        title: Text(ayah.text),
                        trailing: Text(ayah.number.toString()),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
