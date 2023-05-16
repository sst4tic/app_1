import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:io';
import 'barcode_scanner_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

GlobalKey<MainScreenState> scakey = GlobalKey<MainScreenState>();
final tabNavKeys = <GlobalKey<NavigatorState>>[
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  final myKey = GlobalKey<MainScreenState>();
  int currentIndex = 0;
  final CupertinoTabController _controller = CupertinoTabController();
  int badgeCount = 0;
  final List screens = [
    const HomePage(),
    const BarcodeScannerPage(),
    const ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _controller.index = index;
    });
  }

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    subscription.cancel();
    super.dispose();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await tabNavKeys[_controller.index].currentState!.maybePop();
      },
      child: CupertinoTabScaffold(
          controller: _controller,
          key: myKey,
          tabBar: CupertinoTabBar(
            backgroundColor: Theme.of(context).primaryColor,
            activeColor: const Color.fromRGBO(232, 69, 69, 1),
            inactiveColor: Theme.of(context).disabledColor,
            iconSize: 27,
            currentIndex: currentIndex,
            onTap: onItemTapped,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house),
                  activeIcon: Icon(CupertinoIcons.house_fill)),
              // create tab for scanner
              BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person),
                  activeIcon: Icon(CupertinoIcons.person_fill)),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return const HomePage();
              case 1:
                return currentIndex != 1 ? Container()  : const BarcodeScannerPage();
              case 2:
                return CupertinoTabView(
                  navigatorKey: tabNavKeys[index],
                  builder: (BuildContext context) => const ProfilePage(),
                );
              default:
                return Container();
            }
          }),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: const Text('Нет интернет соединения'),
                content: const Text('Пожалуйста проверьте интернет соедниение'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context, 'Cancel');
                      setState(() => isAlertSet = false);
                      isDeviceConnected =
                          await InternetConnectionChecker().hasConnection;
                      if (!isDeviceConnected && isAlertSet == false) {
                        showDialogBox();
                        setState(() => isAlertSet = true);
                      }
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              )
            : AlertDialog(
                title: const Text('Нет интернет соединения'),
                content: const Text('Пожалуйста проверьте интернет соедниение'),
                actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, 'Cancel');
                        setState(() => isAlertSet = false);
                        isDeviceConnected =
                            await InternetConnectionChecker().hasConnection;
                        if (!isDeviceConnected && isAlertSet == false) {
                          showDialogBox();
                          setState(() => isAlertSet = true);
                        }
                      },
                      child: const Text('Повторить'),
                    ),
                  ]),
      );
}
