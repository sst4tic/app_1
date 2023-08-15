part of 'sessions_bloc.dart';

abstract class SessionsState {
  const SessionsState();
}

class SessionsInitial extends SessionsState {
  List<Object> get props => [];
}

class SessionsLoading extends SessionsState {
  const SessionsLoading({this.completer});

  final Completer? completer;

  List<Object> get props => [];
}

class SessionsLoaded extends SessionsState {
  final List sessions;
  final String currentSession;

  const SessionsLoaded({required this.sessions, required this.currentSession});

  List<Object> get props => [sessions, currentSession];
}

class SessionsLoadingFailure extends SessionsState {
  final Object? exception;

  const SessionsLoadingFailure({this.exception});

  List<Object> get props => [exception!];
}