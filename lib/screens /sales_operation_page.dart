import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/operation_sales_bloc/operation_sales_bloc.dart';
import '../models /operation_sales_model.dart';

class OperationSalesPage extends StatefulWidget {
  const OperationSalesPage(
      {Key? key, required this.id, required this.totalPrice})
      : super(key: key);

  final int id;
  final String totalPrice;

  @override
  State<OperationSalesPage> createState() => _OperationSalesPageState();
}

class _OperationSalesPageState extends State<OperationSalesPage> {
  final _operationSalesBloc = OperationSalesBloc();

  @override
  void initState() {
    super.initState();
    _operationSalesBloc.add(LoadOperationSales(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Операции'),
        actions: [
          IconButton(
            onPressed: () {
              _operationSalesBloc.add(CreateOperationSales(id: widget.id));
            },
            icon: const Icon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => OperationSalesBloc(),
        child: BlocBuilder<OperationSalesBloc, OperationSalesState>(
          bloc: _operationSalesBloc,
          builder: (context, state) {
            if (state is OperationSalesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OperationSalesLoaded) {
              return buildOperations(state.operationSales);
            } else if (state is OperationSalesError) {
              return Text(state.e.toString());
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget buildOperations(OperationSalesModel operationSales) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: REdgeInsets.all(8.0),
                margin: REdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Сумма накладной:',
                        style: TextStyles.editStyle.copyWith(fontSize: 13)),
                    Text(widget.totalPrice,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: REdgeInsets.all(8.0),
                margin: REdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Сумма операций:',
                        style: TextStyles.editStyle.copyWith(fontSize: 13)),
                    Text(operationSales.totalPriceBills.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: operationSales.operations.length,
            padding: REdgeInsets.all(8),
            itemBuilder: (context, index) {
              final operation = operationSales.operations[index];
              return Container(
                  padding: REdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  margin: REdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: operation.typeName == 'Поступление'
                          ? Colors.green
                          : Colors.red,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: REdgeInsets.symmetric(vertical: 4),
                        margin: REdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: operation.typeName == 'Поступление'
                              ? Colors.green[200]
                              : Colors.red[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            operation.typeName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: operation.typeName == 'Поступление'
                                    ? Colors.green[900]
                                    : Colors.red[900]),
                          ),
                        ),
                      ),
                      Divider(
                        height: 3.h,
                      ),
                      Center(
                        child: Text(
                          operation.totalSum,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const Divider(),
                      Center(
                        child: Text(
                          operation.billName,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const Divider(),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            Text(
                              operation.managerName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Center(
                        child: Text(
                          operation.createdAt,
                        ),
                      ),
                      operation.btnRemove
                          ? Divider(height: 3.h)
                          : const SizedBox(),
                      operation.btnRemove
                          ? ElevatedButton(
                              onPressed: () {
                                _operationSalesBloc.add(OperationSalesDelete(
                                    id: operation.id, invoiceId: widget.id));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[200],
                              ),
                              child: Text('Удалить сумму',
                                  style: TextStyle(
                                      color: Colors.red[800],
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            )
                          : const SizedBox(),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
