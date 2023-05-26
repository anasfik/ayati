import 'package:ayat_notifications/presentation/general/margined_body.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
            floatingActionButton: Animate(
              delay: 400.ms,
              effects: const [
                FadeEffect(),
              ],
              child: const FAB(),
            ),
            body: MarginedBody(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: BlocBuilder<AlreadyReadedAyahsCubit,
                    AlreadyReadedAyahsState>(
                  builder: (context, state) {
                    final ayatsToShow = state.searchedAyahs.isNotEmpty
                        ? state.searchedAyahs
                        : state.alreadyReadAyahs;

                    return ColoredBox(
                      color: Colors.red,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: ayatsToShow.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Directionality(
                              textDirection: TextDirection.ltr,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(height: kToolbarHeight),
                                  Animate(
                                    delay: 200.ms,
                                    effects: const [
                                      FadeEffect(),
                                    ],
                                    child: const ScreenViewTitle(
                                        text: AppStrings.alreadyReadedAyahs),
                                  ),
                                  const SizedBox(height: height * 2),
                                  Animate(
                                    delay: 400.ms,
                                    effects: const [
                                      FadeEffect(),
                                    ],
                                    child: const SearchBar(),
                                  ),
                                  const SizedBox(height: height * 2),
                                ],
                              ),
                            );
                          } else {
                            final ayah =
                                ayatsToShow.reversed.toList()[index - 1];

                            return Animate(
                              delay: 600.ms + (index * 100).ms,
                              effects: const [
                                FadeEffect(),
                              ],
                              child: ListTile(
                                title: Text(ayah.text),
                                trailing: Text(ayah.number.toString()),
                                subtitle: Text("${ayah.surah?.name}"),
                              ),
                            );
                          }
                        },
                      ),
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
