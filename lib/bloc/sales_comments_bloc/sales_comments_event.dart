part of 'sales_comments_bloc.dart';

abstract class SalesCommentsEvent {}

class LoadCommentsEvent extends SalesCommentsEvent {
  final int id;

  LoadCommentsEvent(this.id);
}

class PostCommentEvent extends SalesCommentsEvent {
  final int id;
  final String message;

  PostCommentEvent({required this.id, required this.message});
}
