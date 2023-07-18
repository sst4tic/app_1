part of 'attendance_bloc.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {
  AttendanceLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class AttendanceLoaded extends AttendanceState {
  AttendanceLoaded({
    required this.attendance,
    required this.date,
  });

  final List<AttendanceModel> attendance;
  final String date;

  List<Object?> get props => [attendance];
}

class AttendanceLoadingFailure extends AttendanceState {
  AttendanceLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}