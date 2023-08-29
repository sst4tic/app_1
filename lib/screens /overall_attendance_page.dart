import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/bloc/overall_attendance_bloc/overall_attendance_bloc.dart';
import 'package:yiwucloud/models%20/overall_attendance_model.dart';
import 'package:yiwucloud/screens%20/map_screen.dart';
import '../util/styles.dart';

class OverallAttendance extends StatefulWidget {
  const OverallAttendance({Key? key}) : super(key: key);

  @override
  State<OverallAttendance> createState() => _OverallAttendanceState();
}

class _OverallAttendanceState extends State<OverallAttendance> {
  final _overallAttendanceBloc = OverallAttendanceBloc();
  String emptyVal = '--:--';

  @override
  void initState() {
    super.initState();
    _overallAttendanceBloc.add(LoadOverallAttendance());
  }

  List originalList = [];
  List filteredList = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OverallAttendanceBloc>(
      create: (context) => OverallAttendanceBloc(),
      child: BlocBuilder<OverallAttendanceBloc, OverallAttendanceState>(
        bloc: _overallAttendanceBloc,
        builder: (context, state) {
          if (state is OverallAttendanceLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is OverallAttendanceLoaded) {
            originalList = state.attendance;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Общая посещаемость'),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50.0),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Поиск',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          contentPadding: const EdgeInsets.all(8),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        onChanged: (value) {
                          _overallAttendanceBloc
                              .add(SearchEvent(search: value));
                        },
                      ),
                    ),
                  ),
                ),
                body: buildAttendance(state.attendance));
          } else if (state is OverallAttendanceLoadingFailure) {
            return Scaffold(
              body: Center(
                child: Text(state.exception.toString()),
              ),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }

  Widget buildAttendance(List<OverallAttendanceModel> attendance) {
    return ListView.builder(
      itemCount: attendance.length,
      itemBuilder: (context, index) {
        final item = attendance[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            onTap: () {
              item.latOut != null || item.latIn != null ? showMap(item) : null;
            },
            isThreeLine: true,
            title: Text(
              '${item.name} ${item.surname}',
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.h),
                Text('Роль: ${item.roleName ?? ''}'),
                SizedBox(height: 4.h),
                item.channelName != null
                    ? Text(
                        'Отдел: ${item.channelName}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.inAt ?? emptyVal,
                style: TextStyles.editStyle.copyWith(
                              fontSize: 13)
                    ),
                    const Text(' - '),
                    Text(
                      item.outAt ?? emptyVal,
                        style: TextStyles.editStyle.copyWith(
                            fontSize: 13)
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Опоздание: ',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      item.lateness ?? emptyVal,
                      style: item.lateness != null
                          ? TextStyles.editStyle
                              .copyWith(color: Colors.red, fontSize: 13)
                          : const TextStyle(),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Ранний приход: ',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      item.earlyArrival ?? emptyVal,
                      style: item.earlyArrival != null
                          ? TextStyles.editStyle
                              .copyWith(color: Colors.green, fontSize: 13)
                          : const TextStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showMap(
    OverallAttendanceModel item,
  ) =>
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: REdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              height: 200,
              child: Column(
                children: [
                  const Text(
                    'Дополнительные действия',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  item.latIn != null && item.lonIn != null
                      ? ListTile(
                          trailing: const Icon(FontAwesomeIcons.mapPin),
                          title: Text(
                            'Показать локацию прихода',
                            style: TextStyles.editStyle.copyWith(fontSize: 14),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        lat: item.latIn!, lon: item.lonIn!)));
                          },
                        )
                      : const SizedBox(),
                  SizedBox(height: 5.h),
                  item.latOut != null && item.lonOut != null
                      ? ListTile(
                          trailing: const Icon(FontAwesomeIcons.mapPin),
                          title: Text(
                            'Показать локацию ухода',
                            style: TextStyles.editStyle.copyWith(fontSize: 14),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapScreen(
                                        lat: item.latOut!, lon: item.lonOut!)));
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            );
          });
}
