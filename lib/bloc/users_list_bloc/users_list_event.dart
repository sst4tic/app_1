part of 'users_list_bloc.dart';

abstract class UsersListEvent {}

class LoadUsersList extends UsersListEvent {
  LoadUsersList({
    this.completer,
    this.query,
    this.filters
  });
  final Completer? completer;
  final String? query;
  final String? filters;

  List<Object?> get props => [completer, query, filters];
}

class LoadMore extends UsersListEvent {
  LoadMore({
    this.completer,
    this.hasMore,
  });

  final Completer? completer;
  final bool? hasMore;
  List<Object?> get props => [];
}