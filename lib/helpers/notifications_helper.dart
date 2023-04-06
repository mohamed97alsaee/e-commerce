import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../widgets/dialogs/custom_flushbar_widget.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'app_channel_id',
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
    showBadge: true,
    enableVibration: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/launcher_icon');
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

onMessageListen(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // Provider.of<NotificationsProvider>(context, listen: false)
        //     .makeHaveUnread();
        flutterLocalNotificationsPlugin.show(
            1,
            "Babak",
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // AndroidInitializationSettings('@mipmap/ic_launcher');

                channel.description,
                icon: '@mipmap/launcher_icon',
                playSound: true,
                enableVibration: true,
                importance: Importance.max,
                priority: Priority.high,
              ),
              // iOS:
            ));

        showCustomFlushbar(notification.body.toString(), Colors.green,
            Icons.notification_add_rounded, context);
      });
    }
  });
}
