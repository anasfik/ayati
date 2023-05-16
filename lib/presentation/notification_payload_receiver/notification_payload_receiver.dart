import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ayat_notifications/logic/app_service/app_service_cubit.dart';
import 'package:flutter/material.dart';

import '../../data/models/ayah.dart';

class NotificationPayloadReceiver extends StatelessWidget {
  const NotificationPayloadReceiver({
    super.key,
    required this.receivedAction,
    required this.appCubit,
  });

  final ReceivedAction receivedAction;
  final AppServiceCubit appCubit;
  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    final currentAyah = Ayah.fromMap(
      jsonDecode(
        receivedAction.payload!["currentAyah"]!,
      ),
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
              "${currentAyah.text}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20.0),
            Text("${currentAyah.number}"),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 50,
              child: ElevatedButton(
                onPressed: () =>
                    appCubit.createNextAyahNotification(currentAyah),
                child: const Text("Show Next Ayah"),
              ),
            ),
            const SizedBox(height: height * 2),
          ],
        ),
      ),
    );
  }
}
