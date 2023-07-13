import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yiwucloud/screens%20/auth/login.dart';
import 'package:yiwucloud/screens%20/main_screen.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/styles.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/auth_bloc/auth_repo.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;
GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Geolocator.requestPermission();
  await Permission.notification.request();
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
                          invoiceId: '0${initialMessage.data['invoice_id']}',
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
    if (message.data['invoice_id'] != null) {
      navKey.currentState!.push(
        MaterialPageRoute(
            builder: (context) => WareHouseSalesDetails(
                  id: int.parse(message.data['id']),
                  invoiceId: '0${message.data['invoice_id']}',
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
                  invoiceId: '0${message.data['invoice_id']}',
                )),
      );
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
  tz.initializeTimeZones();
  runApp(const MyApp());
}

FlutterDataWedge fdw = FlutterDataWedge(profileName: 'DataWedgeFlutterDemo');
late StreamSubscription<ScanResult> onScanResultListener;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
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
    setState(() {
      isLoading = false;
    });
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          Constants.useragent = androidInfo.model;
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          Constants.useragent = iosInfo.utsname.machine;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    onScanResultListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => AuthBloc(authRepo: AuthRepo()),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (Platform.isAndroid && Constants.useragent == 'TC26') {
                fdw.enableScanner(false);
              }
              return GlobalLoaderOverlay(
                child: isLoading
                    ? const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : MaterialApp(
                        localizationsDelegates: const [
                          GlobalMaterialLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          DefaultWidgetsLocalizations.delegate,
                        ],
                        supportedLocales: const [
                          Locale('ru', 'RU'),
                        ],
                        navigatorKey: navKey,
                        debugShowCheckedModeBanner: false,
                        theme: lightTheme,
                        home: (state is Authenticated)
                            ? const MainScreen()
                            : const Login(),
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
