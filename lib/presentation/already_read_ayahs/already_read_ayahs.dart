import 'package:ayat_notifications/presentation/general/margined_body.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/already_read/already_readed_ayahs_cubit.dart';
import '../general/screen_title.dart';
import 'widgets/fab.dart';
import 'widgets/search.dart';

class AlreadyReadedAyahs extends StatelessWidget {
  const AlreadyReadedAyahs({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<AlreadyReadedAyahsCubit>(
      create: (_) => AlreadyReadedAyahsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AlreadyReadedAyahsCubit>();

          return Scaffold(
            appBar: AppBar(),
            floatingActionButton: const FAB(),
            body: MarginedBody(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: BlocBuilder<AlreadyReadedAyahsCubit,
                    AlreadyReadedAyahsState>(
                  builder: (context, state) {
                    final ayatsToShow = state.searchedAyahs.isNotEmpty
                        ? state.searchedAyahs
                        : state.alreadyReadAyahs;

                    return ListView.builder(
                      itemCount: ayatsToShow.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Directionality(
                            textDirection: TextDirection.ltr,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                ScreenTitle(
                                  text: AppStrings.alreadyReadedAyahs,
                                ),
                                SizedBox(height: height * 2),
                                SearchBar(),
                                SizedBox(height: height * 2),
                              ],
                            ),
                          );
                        } else {
                          final ayah = state.alreadyReadAyahs[index - 1];

                          return ListTile(
                            title: Text(ayah.text),
                            trailing: Text(ayah.number.toString()),
                            subtitle: Text("${ayah.surah?.name}"),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
