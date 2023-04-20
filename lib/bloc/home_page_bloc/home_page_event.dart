part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent {}

class LoadHome extends HomePageEvent {
  LoadHome({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}