import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/presentation/general/custom_showcase.dart';
import 'package:ayat_notifications/presentation/home/slide_icon_button.dart';
import 'package:ayat_notifications/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../utils/colors.dart';
import '../../utils/notifications.dart';
import '../../utils/showcase.dart';
import 'current_ayah_box_contents.dart';

class CurrentAyahBox extends StatelessWidget {
  const CurrentAyahBox({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShowcase(
      showcaseKey: Showcaser.ayahsSliderKey,
      description: AppStrings.ayahsSliderDescription,
      title: AppStrings.ayahsSliderTitle,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(.1),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Animate.defaultDuration,
              child: SlideNavigationIconButton(
                icon: FlutterRemix.arrow_left_s_line,
                onPressed: () {
                  final previousAyah =
                      LocalDatabase.instance.previousAyahThanCurrent();
                  NotificationController.createAyahNotification(previousAyah);
                },
              ),
            ),
            const CurrentAyahBoxContents(),
            AnimatedSwitcher(
              duration: Animate.defaultDuration,
              child: SlideNavigationIconButton(
                icon: FlutterRemix.arrow_right_s_line,
                onPressed: () {
                  final nextAyah = LocalDatabase.instance.nextAyahThanCurrent();
                  NotificationController.createAyahNotification(nextAyah);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
