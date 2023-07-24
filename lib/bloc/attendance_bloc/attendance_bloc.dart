import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models /attendance_model.dart';
import '../../util/constants.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc() : super(AttendanceInitial()) {
    Future<List<AttendanceModel>> getAttendance({required String date}) async {
      var url = '${Constants.API_URL_DOMAIN}action=attendance&date_at=$date';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      final data = body['data'];
      final attendance = data
          .map<AttendanceModel>((json) => AttendanceModel.fromJson(json))
          .toList();
      return attendance;
    }

    on<LoadAttendance>((event, emit) async {
      try {
        emit(AttendanceLoading());
        var attendance = await getAttendance(date: event.date);
        emit(AttendanceLoaded(attendance: attendance, date: event.date));
      } catch (e) {
        emit(AttendanceLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
