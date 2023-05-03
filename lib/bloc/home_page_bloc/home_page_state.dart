part of 'home_page_bloc.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {
  HomePageLoading({
    this.completer,
  });

  final Completer? completer;

  List<Object?> get props => [completer];
}

class HomePageLoaded extends HomePageState {
  HomePageLoaded({
    required this.services,
  });

  final List<Services> services;

  List<Object?> get props => [services];
}

class HomePageLoadingFailure extends HomePageState {
  HomePageLoadingFailure({
    this.exception,
  });

  final Object? exception;

  List<Object?> get props => [exception];
}
