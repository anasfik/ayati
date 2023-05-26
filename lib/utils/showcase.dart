import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

abstract class Showcaser {
  static final loadButtonKey = GlobalKey();
  static final startButtonKey = GlobalKey();
  static final statsSectionKey = GlobalKey();

  static const showCaseDelayDuration = Duration(milliseconds: 500);

  static void startShawCase(BuildContext context, List<GlobalKey> list) {
    return ShowCaseWidget.of(context).startShowCase(list);
  }
}
