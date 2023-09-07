part of 'users_list_bloc.dart';

abstract class UsersListState {
  get page => 1;
  bool get hasMore => true;
}

class UsersListInitial extends UsersListState {}

class UsersListLoading extends UsersListState {}

class UsersListLoaded extends UsersListState {
  final UsersListModel usersListModel;
  @override
  final int page;
  @override
  final bool hasMore;

  UsersListLoaded({required this.usersListModel,
    required this.page,
    required this.hasMore});
}

class UsersListLoadingMore extends UsersListState {
  final UsersListModel usersListModel;
  final Completer? completer;

  UsersListLoadingMore(this.usersListModel, this.completer);
}

class UsersListError extends UsersListState {
  final Object? e;

  UsersListError({this.e});
}