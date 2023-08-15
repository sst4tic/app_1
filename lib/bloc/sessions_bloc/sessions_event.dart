part of 'sessions_bloc.dart';

abstract class SessionsEvent {
  const SessionsEvent();
}

class LoadSessions extends SessionsEvent {
  const LoadSessions({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}
