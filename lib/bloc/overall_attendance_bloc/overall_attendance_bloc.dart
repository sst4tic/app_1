import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models /overall_attendance_model.dart';
import '../../util/constants.dart';

part 'overall_attendance_event.dart';

part 'overall_attendance_state.dart';

class OverallAttendanceBloc
    extends Bloc<OverallAttendanceEvent, OverallAttendanceState> {
  OverallAttendanceBloc() : super(OverallAttendanceInitial()) {
    Future<List<OverallAttendanceModel>> getAttendance(
        {required String date}) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=users_workpace&date_at=$date';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      final data = body['data'];
      final attendance = data
          .map<OverallAttendanceModel>(
              (json) => OverallAttendanceModel.fromJson(json))
          .toList();
      return attendance;
    }

    on<LoadOverallAttendance>((event, emit) async {
      try {
        emit(OverallAttendanceLoading());
        var attendance = await getAttendance(date: event.date ?? '');
        emit(OverallAttendanceLoaded(
            attendance: attendance, date: event.date ?? ''));
      } catch (e) {
        emit(OverallAttendanceLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<SearchEvent>((event, emit) async {
      List<OverallAttendanceModel> attendance = state is OverallAttendanceLoaded
          ? (state as OverallAttendanceLoaded).attendance
          : [];
      if (event.search.trim().isEmpty) {
        emit(OverallAttendanceLoaded(
            attendance: await getAttendance(date: ''), date: ''));
      } else {
        List<OverallAttendanceModel> filteredAttendance = attendance
            .where((element) => element.name!
                .toLowerCase()
                .contains(event.search.toLowerCase()))
            .toList();
        emit(OverallAttendanceLoaded(attendance: filteredAttendance, date: ''));
      }
    });
  }
}
