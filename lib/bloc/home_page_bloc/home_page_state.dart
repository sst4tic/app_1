part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {
    List<Object?> get props => [];
  }

class HomePageLoading extends HomePageState{
    HomePageLoading({
      this.completer,
    });

    final Completer? completer;

    List<Object?> get props => [completer];
  }

  class HomePageLoaded extends HomePageState{
    HomePageLoaded({
      required this.items,
    });

    final List items;

    List<Object?> get props => items;
  }

  class HomePageError extends HomePageState{
    HomePageError({
      this.exception,
    });

    final Object? exception;

    List<Object?> get props => [exception];
  }