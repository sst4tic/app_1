import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/sessions_bloc/sessions_repo.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final SessionsRepository sessionsRepo;
  SessionsBloc(this.sessionsRepo) : super(SessionsInitial()) {
    on<LoadSessions>((event, emit) async {
      try {
        emit(const SessionsLoading());
        final sessions = await sessionsRepo.getSessions();
        emit(SessionsLoaded(sessions: sessions.data, currentSession: sessions.currentSession));
      } catch (e) {
        emit(SessionsLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
