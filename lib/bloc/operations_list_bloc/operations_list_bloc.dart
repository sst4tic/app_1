import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models /operations_model.dart';
import 'operations_list_repo.dart';

part 'operations_list_event.dart';
part 'operations_list_state.dart';

class OperationsListBloc extends Bloc<OperationsListEvent, OperationsListState> {
  OperationsListBloc() : super(OperationsListInitial()) {
    final operationsRepo = OperationsListRepo();
    int page = 1;
    String query = '';
    String filters = '';
    on<LoadOperations>((event, emit) async {
      try {
        if (state is! OperationsListLoading) {
          emit(OperationsListLoading());
          filters = event.filters ?? '';
          final operationsList = await operationsRepo.getOperations(page: page, query: event.query, filters: filters);
          query = event.query ?? '';
          emit(OperationsListLoaded(
              operationsList: operationsList, page: 1, hasMore: true));
        }
      } catch (e) {
        emit(OperationsListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<LoadMore>((event, emit) async {
      try {
        if (state is OperationsListLoaded && state.hasMore) {
          final operationsList = (state as OperationsListLoaded).operationsList;
          final newOperationsList =
          await operationsRepo.getOperations(page: state.page + 1, query: query, filters: filters);
          operationsList.operations.addAll(newOperationsList.operations);
          emit(OperationsListLoaded(
              operationsList: operationsList,
              page: state.page + 1,
              hasMore: newOperationsList.operations.length <= 9 ? false : true));
        }
      } catch (e) {
        emit(OperationsListLoadingFailure(exception: e));
      }
    });
  }
}
