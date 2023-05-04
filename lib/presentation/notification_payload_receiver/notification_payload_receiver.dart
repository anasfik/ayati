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
    final currentAyah = Ayah.fromMap(
      jsonDecode(
        receivedAction.payload!["currentAyah"]!,
      ),
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(receivedAction.payload.toString()),
          ),
          ElevatedButton(
            onPressed: () => appCubit.createNextAyahNotification(currentAyah),
            child: Text("next ayah"),
          )
        ],
      ),
    );
  }
}
