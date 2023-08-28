import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/styles.dart';

import '../bloc/operation_creating_bloc/operation_creating_bloc.dart';

class OperationCreatingPage extends StatefulWidget {
  const OperationCreatingPage({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<OperationCreatingPage> createState() => _OperationCreatingPageState();
}

class _OperationCreatingPageState extends State<OperationCreatingPage> {
  final _operationBloc = OperationCreatingBloc();
  final _invoiceController = TextEditingController();
  final _sumController = TextEditingController();
  final _commentController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _operationBloc.add(CheckOperationType(widget.type));
  }

  @override
  void dispose() {
    super.dispose();
    _invoiceController.dispose();
    _sumController.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.type == 'create_operation'
              ? 'Создание операции'
              : 'Создание перемещения'),
        ),
        body: BlocProvider<OperationCreatingBloc>(
            create: (context) => OperationCreatingBloc(),
            child: BlocBuilder<OperationCreatingBloc, OperationCreatingState>(
              bloc: _operationBloc,
              builder: (context, state) {
                if (state is OperationCreateState) {
                  return buildOperationCreate(state);
                } else if (state is MovingCreateState) {
                  return buildMovingCreate(state);
                } else if (state is OperationLoadingFailure) {
                  return Text(state.e.toString());
                } else if (state is OperationCreatingInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Неизвестная ошибка'));
                }
              },
            )));
  }


  int billsIndex = 0;
  int articlesIndex = 0;
  int operationIndex = 0;

  Widget buildOperationCreate(OperationCreateState state) {
    return Container(
      decoration: Decorations.containerDecoration,
      padding: REdgeInsets.all(8),
      margin: REdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'счет'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                items: state.billsList
                    .map((e) =>
                    DropdownMenuItem(
                      value: e.value,
                      child: Text(
                        e.text,
                        maxLines: 1,
                      ),
                    ))
                    .toList(),
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                  ),
                  padding: REdgeInsets.all(8),
                ),
                value: state.billsList[billsIndex].value,
                onChanged: (value) {
                  setState(() {
                    billsIndex = state.billsList
                        .indexWhere((element) => element.text == value);
                  });
                },
              )),
          SizedBox(height: 5.h),
          Text(
            'статья расходов'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          DropdownButtonHideUnderline(
              child: DropdownButton2(
                dropdownStyleData: const DropdownStyleData(),
                isExpanded: true,
                items: state.articlesList
                    .map((e) =>
                    DropdownMenuItem(
                      value: e.value,
                      enabled: e.disabled ? false : true,
                      child: Text(
                        e.text,
                        style: e.disabled
                            ? const TextStyle(color: Colors.grey)
                            : const TextStyle(color: Colors.black),
                        maxLines: 1,
                      ),
                    ))
                    .toList(),
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                  ),
                  padding: REdgeInsets.all(8),
                ),
                value: state.articlesList[articlesIndex].value,
                onChanged: (value) {
                  setState(() {
                    articlesIndex = state.articlesList
                        .indexWhere((element) => element.value == value);
                  });
                },
              )),
          SizedBox(height: 5.h),
          Text(
            'действие'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                items: state.operationTypes
                    .map((e) =>
                    DropdownMenuItem(
                      value: e.value,
                      child: Text(
                        e.text,
                        maxLines: 1,
                      ),
                    ))
                    .toList(),
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                  ),
                  padding: REdgeInsets.all(8),
                ),
                value: state.operationTypes[operationIndex].value,
                onChanged: (value) {
                  setState(() {
                    operationIndex = state.operationTypes
                        .indexWhere((element) => element.value == value);
                  });
                },
              )),
          SizedBox(height: 5.h),
          Text(
            'накладная'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          TextField(
            controller: _invoiceController,
            decoration: const InputDecoration(
              hintText: 'Введите номер накладной',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'сумма'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          TextField(
            controller: _sumController,
            decoration: const InputDecoration(
              hintText: 'Введите сумму',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'комментарии'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Введите комментарий',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[350],
                  ),
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _operationBloc.add(SubmitOperation(
                        billsId: state.billsList[billsIndex].value.toString(),
                        articleId: state.articlesList[articlesIndex].value.toString(),
                        type: state.operationTypes[operationIndex].value.toString(),
                        invoiceId: _invoiceController.text,
                        total: _sumController.text,
                        comments: _commentController.text));
                  },
                  child: const Text('Добавить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


////
  int billsToIndex = 0;
  int billsFromIndex = 0;
  ////
  Widget buildMovingCreate(MovingCreateState state) {
    return Container(
      decoration: Decorations.containerDecoration,
      padding: REdgeInsets.all(8),
      margin: REdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'со счета'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                items: state.billsList
                    .map((e) =>
                    DropdownMenuItem(
                      value: e.value,
                      child: Text(
                        e.text,
                        maxLines: 1,
                      ),
                    ))
                    .toList(),
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                  ),
                  padding: REdgeInsets.all(8),
                ),
                value: state.billsList[billsToIndex].value,
                onChanged: (value) {
                  setState(() {
                    billsToIndex = state.billsList
                        .indexWhere((element) => element.text == value);
                  });
                },
              )),
          SizedBox(height: 5.h),
          Text(
            'на счет'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                items: state.billsList
                    .map((e) =>
                    DropdownMenuItem(
                      value: e.value,
                      child: Text(
                        e.text,
                        maxLines: 1,
                      ),
                    ))
                    .toList(),
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme
                        .of(context)
                        .scaffoldBackgroundColor,
                  ),
                  padding: REdgeInsets.all(8),
                ),
                value: state.billsList[billsFromIndex].value,
                onChanged: (value) {
                  setState(() {
                    billsFromIndex = state.billsList
                        .indexWhere((element) => element.text == value);
                  });
                },
              )),
          SizedBox(height: 5.h),
          Text(
            'сумма'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          TextField(
            controller: _sumController,
            decoration: const InputDecoration(
              hintText: 'Введите сумму',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'комментарии'.toUpperCase(),
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 5.h),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              hintText: 'Введите комментарий',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[350],
                  ),
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _operationBloc.add(SubmitMoving(
                        billsIdFrom: state.billsList[billsFromIndex].value.toString(),
                        billsIdTo: state.billsList[billsToIndex].text.toString(),
                        total: _sumController.text,
                        comments: _commentController.text));
                  },
                  child: const Text('Добавить'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
