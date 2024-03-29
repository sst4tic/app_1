import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:yiwucloud/screens%20/profile/check_screen.dart';
import '../firebase_options.dart';
import '../main.dart';
import '../screens /warehouse_pages/moving_details_page.dart';
import '../screens /warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) {
  navKey.currentState!.push(
    MaterialPageRoute(builder: (context) => const CheckPage()),
  );
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> initNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    var details = await notificationsPlugin.getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      Future.delayed(const Duration(milliseconds: 1000))
          .then((value) => navKey.currentState!.push(
                MaterialPageRoute(builder: (context) => const CheckPage()),
              ));
    }
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse);

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data['invoice_id'] != null) {
        Future.delayed(const Duration(milliseconds: 1250))
            .then((value) => navKey.currentState!.push(
                  MaterialPageRoute(
                      builder: (context) => WareHouseSalesDetails(
                            id: int.parse(initialMessage.data['id']),
                            invoiceId: '${initialMessage.data['invoice_id']}',
                          )),
                ));
      }
      if (initialMessage.data['moving_id'] != null) {
        Future.delayed(const Duration(milliseconds: 1250))
            .then((value) => navKey.currentState!.push(
                  MaterialPageRoute(
                      builder: (context) => MovingDetailsPage(
                            id: int.parse(initialMessage.data['id']),
                            movingId: '${initialMessage.data['moving_id']}',
                          )),
                ));
      }
    }

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        notificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
      if (message.data['invoice_id'] != null) {
        navKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => WareHouseSalesDetails(
                    id: int.parse(message.data['id']),
                    invoiceId: '${message.data['invoice_id']}',
                  )),
        );
      }
      if (message.data['moving_id'] != null) {
        navKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => MovingDetailsPage(
                    id: int.parse(message.data['id']),
                    movingId: '${message.data['moving_id']}',
                  )),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
      if (message!.data['invoice_id'] != null) {
        navKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => WareHouseSalesDetails(
                    id: int.parse(message.data['id']),
                    invoiceId: '${message.data['invoice_id']}',
                  )),
        );
      }
      if (message.data['moving_id'] != null) {
        navKey.currentState!.push(
          MaterialPageRoute(
              builder: (context) => MovingDetailsPage(
                    id: int.parse(message.data['id']),
                    movingId: '${message.data['moving_id']}',
                  )),
        );
      }
    });

    await messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        payload: 'my_payload',
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        const NotificationDetails(
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
                showWhen: false)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
