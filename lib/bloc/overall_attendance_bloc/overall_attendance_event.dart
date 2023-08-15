part of 'overall_attendance_bloc.dart';

abstract class OverallAttendanceEvent {}

class LoadOverallAttendance extends OverallAttendanceEvent {
  LoadOverallAttendance({
    this.completer,
    this.date
  });

  final Completer? completer;
  final String? date;

  List<Object?> get props => [completer];
}

class SearchEvent extends OverallAttendanceEvent {
  SearchEvent({
    this.completer,
    required this.search
  });

  final Completer? completer;
  final String search;

  List<Object?> get props => [completer];
}