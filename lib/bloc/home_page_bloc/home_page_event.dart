part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class LoadServices extends HomePageEvent {
  LoadServices({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}