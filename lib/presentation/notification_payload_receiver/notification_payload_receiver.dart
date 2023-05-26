import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:ayat_notifications/presentation/general/button.dart';
import 'package:flutter/material.dart';

import '../../data/models/ayah.dart';
import '../../utils/notifications.dart';
import '../home/current_ayah_box.dart';
import '../home/current_ayah_box_contents.dart';

class NotificationPayloadReceiver extends StatelessWidget {
  const NotificationPayloadReceiver({
    super.key,
    required this.receivedAction,
  });

  final ReceivedAction receivedAction;
  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    final currentAyah = Ayah.fromMap(
      jsonDecode(
        receivedAction.payload!["currentAyah"]!,
      ),
    );

    return const Scaffold(
      body: Center(child: CurrentAyahBox()),
    );

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: height * 2),
            const Spacer(),
            Text(
              currentAyah.text,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30.0),
            Text("${currentAyah.number}"),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50,
              child: AyatiButton(
                onTap: () => NotificationController.createNextAyahNotification(
                    currentAyah),
                text: "Show Next Ayah",
              ),
            ),
            const SizedBox(height: height * 2),
          ],
        ),
      ),
    );
  }
}
