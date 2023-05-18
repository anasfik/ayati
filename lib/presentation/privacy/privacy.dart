import 'package:flutter/material.dart';

import '../../utils/strings.dart';
import '../general/section_title.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          const SizedBox(height: height * 2),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const SectionTitle(title: AppStrings.privacyPolicy),
          ),
        ],
      ),
    );
  }
}
