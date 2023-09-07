import 'dart:async';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:yiwucloud/bloc/operation_creating_bloc/operation_creating_repo.dart';
import 'package:yiwucloud/main.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/models%20/operation_sales_model.dart';
import 'package:http/http.dart' as http;
import 'package:yiwucloud/util/function_class.dart';
import '../../models /product_filter_model.dart';
import '../../util/constants.dart';

part 'operation_sales_event.dart';

part 'operation_sales_state.dart';

class OperationSalesBloc
    extends Bloc<OperationSalesEvent, OperationSalesState> {
  OperationSalesBloc() : super(OperationSalesInitial()) {
    Future<OperationSalesModel> getOperations({required int id}) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=request_operations_list&id=$id';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      final data = body['data'];
      final operations = OperationSalesModel.fromJson(data);
      return operations;
    }

    Future createOperation(
        {required int id, required billsId, required total}) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=request_bills_post&id=$id&bill_id=$billsId&total=$total';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body;
    }

    Future deleteOperation({required int id, required invoiceId}) async {
      var url =
          '${Constants.API_URL_DOMAIN}action=request_bills_delete&rid=$invoiceId&oid=$id';
      final response =
          await http.get(Uri.parse(url), headers: Constants.headers());
      final body = jsonDecode(response.body);
      return body;
    }

    on<LoadOperationSales>((event, emit) async {
      try {
        emit(OperationSalesLoading());
        final operationSales = await getOperations(id: event.id);
        emit(OperationSalesLoaded(operationSales: operationSales));
      } catch (e) {
        emit(OperationSalesError(e: e));
      }
    });

    on<CreateOperationSales>((event, emit) async {
      try {
        final billsList =
            Hive.box<List<ChildData>>('bills_list').get('bills_list') ??
                await OperationCreatingRepo().getBillsList();
        final sumController = TextEditingController();
        final items = billsList
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.text),
                ))
            .toList();
        var value = items[0].value;
        showDialog(
            context: navKey.currentContext!,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: CustomAlertDialog(
                    title: 'Создание операции',
                    content: StatefulBuilder(builder: (context, innerSetState) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 5.h),
                          DropdownButton2(
                            items: items,
                            isExpanded: true,
                            buttonStyleData: ButtonStyleData(
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              padding: REdgeInsets.all(8),
                            ),
                            underline: Container(),
                            hint: const Text('Выберите счет'),
                            value: value,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                            ),
                            onChanged: (val) {
                              innerSetState(() {
                                value = val;
                              });
                            },
                          ),
                          SizedBox(height: 5.h),
                          TextField(
                            controller: sumController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'Введите сумму',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    actions: [
                      CustomDialogAction(
                        text: 'Отмена',
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CustomDialogAction(
                        text: 'Создать',
                        onPressed: () async {
                          final resp = await createOperation(
                              id: event.id,
                              billsId: value,
                              total: sumController.text);
                          // ignore: use_build_context_synchronously
                          Func().showSnackbar(
                              context, resp['message'], resp['success']);
                          add(LoadOperationSales(id: event.id));
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                      )
                    ]),
              );
            });
      } catch (e) {
        emit(OperationSalesError(e: e));
      }
    });

    on<OperationSalesDelete>((event, emit) async {
      try {
        showDialog(
            context: navKey.currentContext!,
            builder: (context) {
              return CustomAlertDialog(
                  title: 'Удалить сумму',
                  content: const Text(
                      'Вы действительно хотите выполнить данное действие?'),
                  actions: [
                    CustomDialogAction(
                      text: 'Отмена',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CustomDialogAction(
                        text: 'Да',
                        onPressed: () async {
                          final resp = await deleteOperation(
                              id: event.id, invoiceId: event.invoiceId);
                          Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          Func().showSnackbar(navKey.currentContext!,
                              resp['message'], resp['success']);
                          add(LoadOperationSales(id: event.invoiceId));
                        })
                  ]);
            });
      } catch (e) {
        emit(OperationSalesError(e: e));
      }
    });
  }
}
