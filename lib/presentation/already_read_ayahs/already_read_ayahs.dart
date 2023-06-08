import 'package:ayat_notifications/presentation/general/custom_showcase.dart';
import 'package:ayat_notifications/presentation/general/margined_body.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../logic/already_read/already_readed_ayahs_cubit.dart';
import '../../utils/showcase.dart';
import '../general/screen_title.dart';
import 'widgets/fab.dart';
import 'widgets/search.dart';

class AlreadyReadedAyahs extends StatelessWidget {
  const AlreadyReadedAyahs({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    Future.delayed(
      Showcaser.showCaseDelayDuration,
      () {
        Showcaser.startShawCase(
          context,
          <GlobalKey>[
            Showcaser.searchFieldKey,
            Showcaser.searchFabKey,
          ],
        );
      },
    );

    return BlocProvider<AlreadyReadedAyahsCubit>(
      create: (_) => AlreadyReadedAyahsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AlreadyReadedAyahsCubit>();

          return Scaffold(
            floatingActionButton: CustomShowcase(
              showcaseKey: Showcaser.searchFabKey,
              borderRadius: BorderRadius.circular(10),
              description: AppStrings.searchFabKeyDescription,
              title: AppStrings.searchFabKeyTitle,
              child: Animate(
                delay: 400.ms,
                effects: const [
                  FadeEffect(),
                ],
                child: const FAB(),
              ),
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

                    return ListView.builder(
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
                                  child: CustomShowcase(
                                    showcaseKey: Showcaser.searchFieldKey,
                                    title: AppStrings.searchFieldTitle,
                                    description:
                                        AppStrings.searchFieldDescription,
                                    borderRadius: BorderRadius.circular(10),
                                    child: const SearchBar(),
                                  ),
                                ),
                                const SizedBox(height: height * 2),
                              ],
                            ),
                          );
                        } else {
                          final ayah = ayatsToShow.reversed.toList()[index - 1];

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
