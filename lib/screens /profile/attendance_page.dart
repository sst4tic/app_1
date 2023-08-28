import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:yiwucloud/util/constants.dart';
import 'package:yiwucloud/util/function_class.dart';
import '../../bloc/attendance_bloc/attendance_bloc.dart';
import '../../models /attendance_model.dart';
import '../../util/styles.dart';
import '../map_screen.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  DateTimeRange? selectedDateRange;
  final TextEditingController _dateController = TextEditingController();
  final _attendanceBloc = AttendanceBloc();
  final String _date =
      '${DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year, DateTime.now().month, 1))}/${DateFormat('yyyy-MM-dd').format(DateTime.now())}';
  final String emptyTime = '--:--';

  @override
  initState() {
    super.initState();
    _dateController.text = 'С начала месяца';
    _attendanceBloc.add(LoadAttendance(date: _date));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      locale: const Locale('ru', 'RU'),
      saveText: 'Сохранить',
      cancelText: 'Отмена',
      helpText: 'Выберите дату',
      fieldEndLabelText: 'Конец',
      fieldStartLabelText: 'Начало',
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange ??
          DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month, 1),
            end: DateTime.now(),
          ),
    );
    if (picked != null) {
      selectedDateRange = picked;
      final pickedDate =
          '${picked.start.toString().substring(0, 10)} - ${picked.end.toString().substring(0, 10)}';
      final AmanDate =
          '${picked.start.toString().substring(0, 10)}/${picked.end.toString().substring(0, 10)}';
      _dateController.text = pickedDate;
      _attendanceBloc.add(LoadAttendance(date: AmanDate));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: const Text('Посещаемость'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: Colors.white,
              padding: REdgeInsets.all(8.0),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () async {
                  await _selectDate(context);
                },
                decoration: const InputDecoration(
                  hintText: 'Выберите дату',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                ),
              ),
            ),
          )),
      body: BlocProvider(
        create: (context) => AttendanceBloc(),
        child: BlocBuilder<AttendanceBloc, AttendanceState>(
          bloc: _attendanceBloc,
          builder: (context, state) {
            if (state is AttendanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AttendanceLoaded) {
              return buildAttendanceList(state.attendance);
            } else if (state is AttendanceLoadingFailure) {
              return Center(child: Text(state.exception.toString()));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget buildAttendanceList(List<AttendanceModel> attendance) {
    return ListView.separated(
        itemCount: attendance.length,
        itemBuilder: (context, index) {
          final attendanceItem = attendance[index];
          return ListTile(
            title: Text(attendance[index].day.capitalize(),
                style: TextStyles.editStyle.copyWith(fontSize: 14)),
            onTap: () {
              attendanceItem.locations.isNotEmpty
                  ? showMap(attendanceItem.locations)
                  : null;
            },
            trailing: attendanceItem.dayOff
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.holiday_village,
                        color: Colors.blue,
                        size: 15,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Выходной',
                        style: TextStyles.editStyle
                            .copyWith(fontSize: 13, color: Colors.blue),
                      ),
                    ],
                  )
                : (attendanceItem.outAt == null && attendanceItem.inAt == null)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: Colors.yellow[600],
                            size: 15,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Не отметился',
                            style: TextStyles.editStyle.copyWith(
                                fontSize: 13, color: Colors.yellow[600]),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                attendanceItem.inAt ?? emptyTime,
                                style: TextStyles.editStyle.copyWith(
                                    color: check(
                                            attendanceItem.startSchedule ??
                                                Constants.startAt,
                                            attendanceItem.inAt!)
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 13),
                              ),
                              Text(attendanceItem.startSchedule ?? emptyTime,
                                  style: TextStyles.editStyle.copyWith(
                                      fontSize: 13, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                attendanceItem.outAt ?? emptyTime,
                                style: TextStyles.editStyle.copyWith(
                                    color: attendanceItem.outAt != null
                                        ? checkOut(Constants.endAt,
                                                attendanceItem.outAt!)
                                            ? Colors.red
                                            : Colors.green
                                        : Colors.grey,
                                    fontSize: 13),
                              ),
                              Text(attendanceItem.endSchedule ?? emptyTime,
                                  style: TextStyles.editStyle.copyWith(
                                      fontSize: 13, color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 0);
        });
  }

  showMap(
    List<Locations> item,
  ) =>
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                const Text(
                  'Дополнительные действия',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 5.h,
                ),
                ListView.separated(
                  padding: REdgeInsets.all(8),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 6.h);
                  },
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: const Icon(FontAwesomeIcons.mapPin),
                      title: Text(
                        // item[index].createdAt,
                        'asdsad',
                        style: TextStyles.editStyle.copyWith(fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen(
                                    lat: item[index].lat,
                                    lon: item[index].lon)));
                      },
                    );
                  },
                ),
              ],
            );
          });
}
