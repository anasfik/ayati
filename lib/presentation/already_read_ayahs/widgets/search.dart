import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.red
    return TextField(
      controller: 
      decoration: InputDecoration(
        hintText: AppStrings.typeHere,
        suffixIcon: Icon(
          FlutterRemix.search_2_line,
          size: 22,
          color: Theme.of(context).iconTheme.color!.withOpacity(.4),
        ),
      ),
    );
  }
}
