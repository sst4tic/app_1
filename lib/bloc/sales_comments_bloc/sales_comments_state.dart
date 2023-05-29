part of 'sales_comments_bloc.dart';

abstract class SalesCommentsState {}

class SalesCommentsInitial extends SalesCommentsState {}

class SalesCommentsLoading extends SalesCommentsState {
  SalesCommentsLoading({this.completer});


  final Completer? completer;

  List<Object?> get props => [completer];
}

class SalesCommentsLoaded extends SalesCommentsState {
  final List<CommentModel> salesComments;

  SalesCommentsLoaded(this.salesComments);
}

class SalesCommentsError extends SalesCommentsState {
  final Object exception;

  SalesCommentsError(this.exception);
}