import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models /users_list_model.dart';
import '../../util/constants.dart';


part 'users_list_event.dart';
part 'users_list_state.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  UsersListBloc() : super(UsersListInitial()) {
    int page = 1;
    String query = '';
    String filters = '';
    //
    Future<UsersListModel> getUsers({required int page, String? query, String? filters}) async {
      var url = '${Constants.API_URL_DOMAIN}action=users_list&page=$page&smart=${query ?? ''}&${filters ?? ''}';
      final response = await http.get(
          Uri.parse(url),
          headers: Constants.headers()
      );
      final body = jsonDecode(response.body);
      return UsersListModel.fromJson(body['data']);
    }
    //
    on<LoadUsersList>((event, emit) async {
      try {
        if (state is! UsersListLoading) {
          emit(UsersListLoading());
          filters = event.filters ?? '';
          final usersListModel = await getUsers(page: page, query: event.query, filters: event.filters);
          query = event.query ?? '';
          emit(UsersListLoaded(
              usersListModel: usersListModel, page: 1, hasMore: true));
        }
      } catch (e) {
        emit(UsersListError(e: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<LoadMore>((event, emit) async {
      try {
        if (state is UsersListLoaded && state.hasMore) {
          final usersListModel = (state as UsersListLoaded).usersListModel;
          final newUsersListModel =
          await getUsers(page: state.page + 1, query: query, filters: filters);
          usersListModel.users.addAll(newUsersListModel.users);
          emit(UsersListLoaded(
              usersListModel: usersListModel,
              page: state.page + 1,
              hasMore: newUsersListModel.users.length <= 10 ? false : true));
        }
      } catch (e) {
        emit(UsersListError(e: e));
      }
    });
  }
}
