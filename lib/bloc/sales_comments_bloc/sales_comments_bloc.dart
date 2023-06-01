import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/comment_model.dart';
import 'package:yiwucloud/util/function_class.dart';
part 'sales_comments_event.dart';
part 'sales_comments_state.dart';

class SalesCommentsBloc extends Bloc<SalesCommentsEvent, SalesCommentsState> {
  late int _id;

  set id(int value) => _id = value;

  SalesCommentsBloc() : super(SalesCommentsInitial()) {
    on<LoadCommentsEvent>((event, emit) async {
      try {
        if (state is! SalesCommentsLoading) {
          emit(SalesCommentsLoading());
          final comments = await Func().getComments(id: event.id);
          emit(SalesCommentsLoaded(comments));
        }
      } catch (e) {
        emit(SalesCommentsError(e));
      }
    });
    on<PostCommentEvent>((event, emit) async {
      try {
        if (state is SalesCommentsLoaded) {
        await Func().postComment(id: event.id, message: event.message);
          final comments = await Func().getComments(id: event.id);
          emit(SalesCommentsLoaded(comments));
        }
      } catch (e) {
        emit(SalesCommentsError(e));
      }
    });
  }

}
