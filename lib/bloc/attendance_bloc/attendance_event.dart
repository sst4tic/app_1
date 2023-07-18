part of 'attendance_bloc.dart';

abstract class AttendanceEvent {}

class LoadAttendance extends AttendanceEvent {
  LoadAttendance({
    this.completer,
    required this.date
  });

  final Completer? completer;
  final String date;

  List<Object?> get props => [completer];
}