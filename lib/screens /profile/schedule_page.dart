import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:yiwucloud/util/styles.dart';
import '../../models /schedule_model.dart';
import '../../util/constants.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final Future<List<ScheduleModel>> _scheduleFuture;

  @override
  initState() {
    super.initState();
    _scheduleFuture = getSchedule();
  }

  Future<List<ScheduleModel>> getSchedule() async {
    var url = '${Constants.API_URL_DOMAIN}action=schedule';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data'];
    return data
        .map<ScheduleModel>((json) => ScheduleModel.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Расписание'),
      ),
      body: FutureBuilder<List<ScheduleModel>>(
        future: _scheduleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: REdgeInsets.all(4),
              itemBuilder: (context, index) {
                final day = snapshot.data![index];
                return Card(
                  elevation: 0,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      padding: REdgeInsets.all(12),
                      height: double.infinity,
                      width: 55.w,
                      child: Center(
                          child: Text(
                        day.day,
                        style: TextStyles.editStyle
                            .copyWith(fontSize: 14, color: Colors.black),
                      )),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        day.isDayoff
                            ? Container(
                                padding: REdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green[300],
                                ),
                                child: const Text('Выходной'))
                            : Container(
                                padding: REdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                child: const Text('По умолчанию')),
                        SizedBox(
                          height: 5.h,
                        )
                      ],
                    ),
                    subtitle: day.isDayoff
                        ? const SizedBox()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.clock,
                                size: 14,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                day.startAt ?? '',
                                style: TextStyles.editStyle.copyWith(
                                    fontSize: 14, color: Colors.blue),
                              ),
                              Text(
                                ' - ',
                                style: TextStyles.editStyle.copyWith(
                                    fontSize: 14, color: Colors.blue),
                              ),
                              Text(
                                day.endAt ?? '',
                                style: TextStyles.editStyle.copyWith(
                                    fontSize: 14, color: Colors.blue),
                              ),
                            ],
                          ),
                  ),
                );
              },
            );
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }
}
