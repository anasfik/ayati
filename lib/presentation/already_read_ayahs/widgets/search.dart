import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../logic/already_read/already_readed_ayahs_cubit.dart';
import '../../../utils/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AlreadyReadedAyahsCubit>();

    return BlocBuilder<AlreadyReadedAyahsCubit, AlreadyReadedAyahsState>(
      builder: (context, state) {
        final userDidSearch = state.searchedAyahs.isNotEmpty;

        return TextField(
          controller: cubit.searchController,
          decoration: InputDecoration(
            hintText: AppStrings.typeHere,
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: userDidSearch
                  ? GestureDetector(
                      onTap: () {
                        cubit.resetSearch();
                      },
                      child: Icon(
                        FlutterRemix.close_line,
                        size: 22,
                        color:
                            Theme.of(context).iconTheme.color!.withOpacity(.4),
                      ),
                    )
                  : Icon(
                      FlutterRemix.search_2_line,
                      size: 22,
                      color: Theme.of(context).iconTheme.color!.withOpacity(.4),
                    ),
            ),
          ),
        );
      },
    );
  }
}
