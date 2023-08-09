import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yiwucloud/screens%20/check_screen.dart';
import 'package:yiwucloud/screens%20/documents_page.dart';
import 'package:yiwucloud/screens%20/info_page.dart';
import 'package:yiwucloud/util/constants.dart';
import '../bloc/auth_bloc/auth_bloc.dart';
import '../models /build_user.dart';
import '../models /custom_dialogs_model.dart';
import '../util/styles.dart';
import '../util/user.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> _future;
  late AuthBloc _authBloc;
  String version = '';

  static Future<User> getUser() async {
    var url = '${Constants.API_URL_DOMAIN}action=user_profile';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    return User.fromJson(body['data']);
  }

  Future<void> refresh() async {
    setState(() {
      _future = getUser();
    });
  }

  @override
  void initState() {
    super.initState();
    _future = getUser();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    getVersion();
  }

  void getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Container(
        padding: REdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              padding: REdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: FutureBuilder<User>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return buildUser(user, () => refresh());
                  } else {
                    return const Center(
                      child: Text('Не удалось загрузить пользователя'),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Text('Работа'.toUpperCase(), style: TextStyles.headerStyle2),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DocumentsPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )),
                padding: REdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.description,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Мои документы', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const FinancePage()));
            //   },
            //   child: Container(
            //     padding: REdgeInsets.all(10),
            //     decoration:
            //     BoxDecoration(color: Theme.of(context).primaryColor),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Container(
            //           width: 25,
            //           height: 25,
            //           decoration: BoxDecoration(
            //             color: Colors.orange,
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           child: const Icon(
            //             Icons.attach_money,
            //             color: Colors.white,
            //             size: 20,
            //           ),
            //         ),
            //         SizedBox(width: 5.h),
            //         Text('Финансы', style: TextStyles.bodyStyle),
            //         const Spacer(),
            //         const Icon(
            //           Icons.arrow_forward_ios,
            //           color: Colors.grey,
            //           size: 15,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                padding: REdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Рабочее время', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text('Аккаунт'.toUpperCase(), style: TextStyles.headerStyle2),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPage(
                      version: version,
                    ),
                  ),
                );
              },
              child: Container(
                padding: REdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('О приложении', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                _authBloc.add(DeleteAccountEvent(context: context));
              },
              child: Container(
                padding: REdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Удалить аккаунт', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: "Выход из аккаунта",
                        content: const Text("Вы действительно хотите выйти?"),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              _authBloc.add(LoggedOut());
                              Navigator.pop(context);
                            },
                            child: const Text('Да'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Нет'),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                padding: REdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Выйти из аккаунта', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Center(
                child: Text('Версия приложения $version',
                    style: TextStyles.editStyle)),
          ],
        ),
      ),
    );
  }
}
