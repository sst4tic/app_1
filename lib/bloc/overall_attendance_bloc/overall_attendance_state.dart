part of 'overall_attendance_bloc.dart';

abstract class OverallAttendanceState {}

class OverallAttendanceInitial extends OverallAttendanceState {}

class OverallAttendanceLoading extends OverallAttendanceState {
  OverallAttendanceLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class OverallAttendanceLoaded extends OverallAttendanceState {
  OverallAttendanceLoaded({
    required this.attendance,
    required this.date,
  });

  List<OverallAttendanceModel> attendance;
  final String date;

  List<Object?> get props => [attendance];
}

class OverallAttendanceLoadingFailure extends OverallAttendanceState {
  OverallAttendanceLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}