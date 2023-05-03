import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiwucloud/screens%20/auth/login.dart';
import 'package:yiwucloud/screens%20/main_screen.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/styles.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/auth_bloc/auth_repo.dart';
import 'firebase_options.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await Permission.notification.request();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // Future.delayed(const Duration(milliseconds: 100)).then((value) => navKey
    //     .currentState !=
    //     null
    //     ? navKey.currentState!.push(
    //     MaterialPageRoute(builder: (context) => const NotificationScreen()))
    //     : null);
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
      flutterLocalNotificationsPlugin.show(
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
  });
  FirebaseMessaging.onBackgroundMessage(
          (message) => _firebaseMessagingBackgroundHandler(message));

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
    if (navKey.currentState != null) {
      if (Constants.USER_TOKEN.isNotEmpty) {
        // navKey.currentState!.push(MaterialPageRoute(
        //     builder: (context) => const NotificationScreen()));
      }
    }
  });

  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@drawable/ic_notification');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await messaging.requestPermission();
  if (Platform.isIOS) {
    var APNS = await messaging.getAPNSToken();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      Constants.USER_TOKEN = pref.getString('login') ?? "";
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getToken();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => AuthBloc(authRepo: AuthRepo()),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                home: (state is Authenticated) ? const MainScreen() : const Login(),
              );
            },
          ),
        );
      },
    );
  }
}
/////////
//User model with role property type UserType
// class User {
//   var hasPer = [];
//
//   if(in_array(permission, hasPer))
//    return true;
//   else
//    return false;
// }
//
// User::hasPer('addition-article');
//
// // enum with cases admin and user
// enum UserType { admin, user }
//
// // interface with isAvailable func
// abstract class ViewAvailability {
//   bool isAvailable();
//
//   //default implementation of isAvailable func
//   bool isAvailableDefault() {
//     switch (User(UserType.admin).role) {
//       case UserType.admin:
//         return true;
//       case UserType.user:
//         return false;
//     }
//   }
// }
//
// // button view confirms to ViewAvailability
// class ButtonView implements ViewAvailability {
//   @override
//   bool isAvailable() {
//     //switch by User role cases
//     switch (User(UserType.admin).role) {
//       case UserType.admin:
//         return false;
//       case UserType.user:
//         return true;
//     }
//   }
// }
//
// // textfield confirms to ViewAvailability
// class TextFieldView implements ViewAvailability {
//   @override
//   bool isAvailable() {
//     //switch by User role cases
//     switch (User(UserType.user).role) {
//       case UserType.admin:
//         return false;
//       case UserType.user:
//         return true;
//     }
//   }
// }
//
// var button = ButtonView()
// button.isHidden = button.isAvailableDefault();