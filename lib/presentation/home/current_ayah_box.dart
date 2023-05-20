import 'package:ayat_notifications/data/local/local.dart';
import 'package:ayat_notifications/presentation/home/slide_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../utils/colors.dart';
import 'current_ayah_box_contents.dart';

class CurrentAyahBox extends StatelessWidget {
  const CurrentAyahBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SlideNavigationIconButton(
            icon: FlutterRemix.arrow_left_s_line,
            onPressed: () {
              LocalDatabase.instance.previousAyahThanCurrent();
            },
          ),
          const CurrentAyahBoxContents(),
          SlideNavigationIconButton(
            icon: FlutterRemix.arrow_right_s_line,
            onPressed: () {
              LocalDatabase.instance.nextAyahThanCurrent();
            },
          ),
        ],
      ),
    );
  }
}
