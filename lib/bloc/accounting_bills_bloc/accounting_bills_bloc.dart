import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/main.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/util/function_class.dart';

import '../../models /accounting_bills_model.dart';
import 'accounting_bills_repo.dart';

part 'accounting_bills_event.dart';

part 'accounting_bills_state.dart';

class AccountingBillsBloc
    extends Bloc<AccountingBillsEvent, AccountingBillsState> {
  AccountingBillsBloc() : super(AccountingBillsInitial()) {
    final billsRepo = AccountingBillsRepo();
    int page = 1;
    on<LoadAccountingBills>((event, emit) async {
      try {
        emit(AccountingBillsLoading());
        final bills = await billsRepo.getBills(page: page);
        emit(AccountingBillsLoaded(bills: bills, page: page, hasMore: true));
      } catch (e) {
        emit(AccountingBillsError(e: e));
      }
    });

    on<LoadMore>((event, emit) async {
      try {
        if (state is AccountingBillsLoaded && state.hasMore) {
          final bills = (state as AccountingBillsLoaded).bills;
          final newBills = await billsRepo.getBills(page: state.page + 1);
          bills.bills.addAll(newBills.bills);
          emit(AccountingBillsLoaded(
              bills: bills,
              page: state.page + 1,
              hasMore: newBills.bills.length <= 10 ? false : true));
        }
      } catch (e) {
        emit(AccountingBillsError(e: e));
      }
    });

    on<CreateAccountingBills>((event, emit) async {
      try {
        final nameController = TextEditingController();
        final items = await billsRepo.getBillsTypes();
        final mappedItems = items
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.text.toString()),
                ))
            .toList();
        var val = mappedItems[0].value;
        showDialog(
            context: navKey.currentContext!,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: CustomAlertDialog(
                  title: 'Добавление счета',
                  content: StatefulBuilder(builder: (context, innerSetState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Название*'),
                        SizedBox(height: 3.h),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const Text('Тип*'),
                        SizedBox(height: 3.h),
                        DropdownButton2(
                          isExpanded: true,
                          underline: Container(),
                          buttonStyleData: ButtonStyleData(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              padding: REdgeInsets.all(8)),
                          items: mappedItems,
                          value: val,
                          onChanged: (value) {
                            innerSetState(() {
                              val = value;
                            });
                          },
                        )
                      ],
                    );
                  }),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final resp = await billsRepo.createBill(
                            name: nameController.text,
                            type: int.parse(val.toString()));
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        Func().showSnackbar(navKey.currentContext!,
                            resp['message'], resp['success']);
                        if (resp['success']) {
                          add(LoadAccountingBills());
                        }
                      },
                      child: const Text('Добавить'),
                    )
                  ],
                ),
              );
            });
      } catch (e) {
        emit(AccountingBillsError(e: e));
      }
    });

    on<BillsEditEvent>((event, emit) async {
      try {
        final nameController = TextEditingController(
          text: event.name,
        );
        final items = await billsRepo.getBillsTypes();
        final mappedItems = items
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.text.toString()),
                ))
            .toList();
        var val = mappedItems[0].value;
        showDialog(
            context: navKey.currentContext!,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: CustomAlertDialog(
                  title: 'Редактирование',
                  content: StatefulBuilder(builder: (context, innerSetState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Название*'),
                        SizedBox(height: 3.h),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const Text('Тип*'),
                        SizedBox(height: 3.h),
                        DropdownButton2(
                          isExpanded: true,
                          underline: Container(),
                          buttonStyleData: ButtonStyleData(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              padding: REdgeInsets.all(8)),
                          items: mappedItems,
                          value: val,
                          onChanged: (value) {
                            innerSetState(() {
                              val = value;
                            });
                          },
                        )
                      ],
                    );
                  }),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final resp = await billsRepo.editBill(
                            id: event.id,
                            name: nameController.text,
                            type: int.parse(val.toString()));
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        Func().showSnackbar(navKey.currentContext!,
                            resp['message'], resp['success']);
                        if (resp['success']) {
                          add(LoadAccountingBills());
                        }
                      },
                      child: const Text('Сохранить'),
                    )
                  ],
                ),
              );
            });
      } catch (e) {
        emit(AccountingBillsError(e: e));
      }
    });
  }
}
