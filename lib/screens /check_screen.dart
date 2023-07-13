import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yiwucloud/bloc/check_bloc/check_bloc.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import '../util/styles.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  String emptyTime = '--:--';
  final _checkBloc = CheckBloc();

  @override
  void initState() {
    super.initState();
    _checkBloc.add(LoadCheck());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Рабочее время'),
          centerTitle: false,
        ),
        body: BlocBuilder<CheckBloc, CheckState>(
          bloc: _checkBloc,
          builder: (context, state) {
            if (state is CheckLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckLoaded) {
              final workpace = state.check;
              return Padding(
                padding: REdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: REdgeInsets.all(8.0),
                      decoration: Decorations.containerDecoration,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.circle_outlined,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 5.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workpace.schedule ?? emptyTime,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Рабочее время',
                                    style: TextStyles.editStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(workpace.comingToday ?? emptyTime,
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                  Text(
                                    'Приход',
                                    style: TextStyles.editStyle,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(workpace.leavingToday ?? emptyTime,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    'Уход',
                                    style: TextStyles.editStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'статистика'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: REdgeInsets.all(8.0),
                      decoration: Decorations.containerDecoration,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Отработано сегодня'),
                              Text(workpace.todayWork ?? emptyTime),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Отработано за месяц'),
                              Text(workpace.totalWork ?? emptyTime),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // ElevatedButton(onPressed: () async {
                    //  await NotificationService().scheduleNotification(scheduledNotificationDateTime:
                    //   DateTime.now().add(const Duration(seconds: 10)),
                    //    title: 'Scheduled Notification',
                    //    body: 'You should see this notification in 5 seconds',
                    //   );
                    // }, child: const Text('test')),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final position = await Geolocator.getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);
                          // ignore: use_build_context_synchronously
                          _checkBloc.add(CheckLocationEvent(
                              lat: position.latitude,
                              lon: position.longitude,
                              context: context,
                              type: workpace.btnType == 'in' ? 'in' : 'out'));
                        } catch (e) {
                          showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                    title: 'Ошибка',
                                    content: Text(
                                        '${e.toString()}\n Проверьте разрешение в настройках'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await Permission.location.request();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ок'))
                                    ],
                                  ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: workpace.btnType == 'in'
                              ? Colors.blue
                              : Colors.red,
                          minimumSize: const Size(double.infinity, 40)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: workpace.btnType == 'in'
                            ? [
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                const Spacer(),
                                const Text(
                                  'Пришел на работу',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                              ]
                            : [
                                const Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                const Spacer(),
                                const Text(
                                  'Ушел с работы',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                              ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is CheckLoadingFailure) {
              return Center(
                child: Text(state.exception.toString()),
              );
            } else {
              return const Center(
                child: Text('Ошибка'),
              );
            }
          },
        ));
  }
}
