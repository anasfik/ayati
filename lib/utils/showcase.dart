import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

abstract class Showcaser {
  static final GlobalKey loadButtonKey = GlobalKey();
  static final GlobalKey startButtonKey = GlobalKey();
  static final GlobalKey statsSectionKey = GlobalKey();
  static final GlobalKey ayahsSliderKey = GlobalKey();
  static final GlobalKey searchFieldKey = GlobalKey();

  static final GlobalKey searchFabKey = GlobalKey();

  static const Duration showCaseDelayDuration = Duration(milliseconds: 200);

  static void startShawCase(BuildContext context, List<GlobalKey> list) {
    return ShowCaseWidget.of(context).startShowCase(list);
  }
}
