import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/main.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';

import '../../models /operations_model.dart';
import '../../util/function_class.dart';
import 'operations_list_repo.dart';

part 'operations_list_event.dart';

part 'operations_list_state.dart';

class OperationsListBloc
    extends Bloc<OperationsListEvent, OperationsListState> {
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
          final operationsList = await operationsRepo.getOperations(
              page: page, query: event.query, filters: filters);
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
          final newOperationsList = await operationsRepo.getOperations(
              page: state.page + 1, query: query, filters: filters);
          operationsList.operations.addAll(newOperationsList.operations);
          emit(OperationsListLoaded(
              operationsList: operationsList,
              page: state.page + 1,
              hasMore:
                  newOperationsList.operations.length <= 9 ? false : true));
        }
      } catch (e) {
        emit(OperationsListLoadingFailure(exception: e));
      }
    });

    on<DeleteOperation>((event, emit) async {
      try {
        showDialog(
            context: navKey.currentContext!,
            builder: (context) => CustomAlertDialog(
                title: 'Удаление операции',
                content: const Text('Вы действительно хотите удалить операцию?'),
                actions: [
                  CustomDialogAction(text: 'Нет', onPressed: () => Navigator.pop(context)),
                  CustomDialogAction(
                      text: 'Да',
                      onPressed: () async {
                        final resp = await operationsRepo.deleteOperation(
                            id: event.id);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Func().showSnackbar(
                            context, resp['message'], resp['success']);
                        add(LoadOperations());
                      })
                ]));
      } catch (e) {
        emit(OperationsListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
