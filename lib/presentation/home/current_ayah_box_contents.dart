import 'package:ayat_notifications/presentation/general/button.dart';
import 'package:flutter/material.dart';

import '../../data/local/local.dart';

class CurrentAyahBoxContents extends StatelessWidget {
  const CurrentAyahBoxContents({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: LocalDatabase.instance.currentAyahStream(),
      builder: (context, state) {
        final surahNameText = Text(
          state.data == null
              ? "---"
              : "${state.data!.surah!.name} - ${state.data!.surah!.number}",
          textAlign: TextAlign.center,
          textDirection: Directionality.of(context),
        );

        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: heightOfTextWidget(surahNameText)),
              Text(
                state.data == null ? "---" : state.data!.text,
                textAlign: TextAlign.center,
              ),
              surahNameText,
            ],
          ),
        );
      },
    );
  }
}

double heightOfTextWidget(Text textWidget) {
  TextPainter painter = TextPainter(
    textDirection: textWidget.textDirection,
    text: TextSpan(
      text: textWidget.data,
      style: textWidget.style,
    ),
  );

  painter.textDirection = textWidget.textDirection;

  painter.layout();

  final height = painter.height;

  return height;
}
