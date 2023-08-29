import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:yiwucloud/bloc/operation_creating_bloc/operation_creating_repo.dart';
import 'package:yiwucloud/main.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/models%20/product_filter_model.dart';

import '../../models /articles_list_model.dart';

part 'operation_creating_event.dart';

part 'operation_creating_state.dart';

class OperationCreatingBloc
    extends Bloc<OperationCreatingEvent, OperationCreatingState> {
  OperationCreatingBloc() : super(OperationCreatingInitial()) {
    final operationRepo = OperationCreatingRepo();
    final billsList = Hive.box<List<ChildData>>('bills_list')
        .get('bills_list');
    on<CheckOperationType>((event, emit) async {
      if (event.type == 'create_operation') {
        final articlesList = await operationRepo.getArticlesList();
        final operationTypes = await operationRepo.getOperationTypes();
        emit(OperationCreateState(
          billsList: billsList ?? await operationRepo.getBillsList(),
          articlesList: articlesList,
          operationTypes: operationTypes,
          invoiceId: '',
          totalSum: '',
        ));
      } else if (event.type == 'create_moving') {
        emit(MovingCreateState(
          billsList: billsList ?? await operationRepo.getBillsList(),
          totalSum: '',
        ));
      } else {
        emit(OperationLoadingFailure('Неизвестный тип операции'));
      }
    });

    on<SubmitMoving>((event, emit) async {
      try {
        final resp = await operationRepo.submitMoving(
          billsIdFrom: event.billsIdFrom,
          billsIdTo: event.billsIdTo,
          total: event.total,
          comments: event.comments,
        );
        // ignore: use_build_context_synchronously
        showDialog(context: navKey.currentState!.context, builder: (context) => CustomAlertDialog(
          title: resp['success'] ? 'Успешно!' : 'Произошла ошибка!',
          content: Text(resp['message']),
          actions: [
            CustomDialogAction(
              text: 'Ок',
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
      } catch (e) {
        emit(OperationLoadingFailure(e));
      }
    });

    on<SubmitOperation>((event, emit) async {
      try {
        final resp = await operationRepo.submitAddition(
          billsId: event.billsId,
          type: event.type,
          articleId: event.articleId,
          invoiceId: event.invoiceId,
          total: event.total,
          comments: event.comments,
        );
        // ignore: use_build_context_synchronously
        showDialog(context: navKey.currentState!.context, builder: (context) => CustomAlertDialog(
          title: resp['success'] ? 'Успешно!' : 'Произошла ошибка!',
          content: Text(resp['message']),
          actions: [
            CustomDialogAction(
              text: 'Ок',
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
      } catch (e) {
        emit(OperationLoadingFailure(e));
      }
    });
  }
}
