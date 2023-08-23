import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/arrival_existence_model.dart';

import '../../bloc/create_arrival_bloc/create_arrival_bloc.dart';
import '../../util/styles.dart';

class CreateArrivalPage extends StatefulWidget {
  const CreateArrivalPage({Key? key}) : super(key: key);

  @override
  State<CreateArrivalPage> createState() => _CreateArrivalPageState();
}

class _CreateArrivalPageState extends State<CreateArrivalPage> {
  final _createArrivalBloc = CreateArrivalBloc();
  var dropdownVal = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider<CreateArrivalBloc>(
          create: (context) => CreateArrivalBloc(),
          child: BlocBuilder<CreateArrivalBloc, CreateArrivalState>(
            bloc: _createArrivalBloc,
            builder: (context, state) {
              if (state is CreateArrivalInitial) {
                return buildArrivalCreate();
              } else if (state is ArrivalExist) {
                return buildExistModel(state.arrival, state.warehouses);
              } else if (state is ArrivalNotExist) {
                return buildNonExistModel(state.warehouses, state.sku);
              } else if (state is CreateArrivalError) {
                return Center(
                  child: Text(state.e.toString()),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }

  // for existing product
  Widget buildExistModel(ArrivalExistenceModel arrival,
      List<DropdownMenuItem<String>> warehouses) {
    final countController = TextEditingController();
    final nameController = TextEditingController(text: arrival.product!.name);
    return Container(
      decoration: Decorations.containerDecoration,
      padding: REdgeInsets.all(8),
      margin: REdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Товар существует, добавьте кол-во прихода',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 15, color: Colors.black)),
          const Divider(),
          Text('Артикул:',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: arrival.product!.sku,
              labelStyle: TextStyle(color: Colors.grey[800]),
              filled: true,
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text('Количество*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: countController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Введите количество',
              labelStyle: TextStyle(color: Colors.grey[800]),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          Text(
            'Наличие товара: ${arrival.availability!.map((e) => e)}',
            style: TextStyles.editStyle,
          ),
          SizedBox(height: 10.h),
          Text('Склад*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          StatefulBuilder(builder: (context, innerSetState) {
            return DropdownButtonHideUnderline(
                child: DropdownButton2(
              buttonStyleData: ButtonStyleData(
                  height: 35.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  padding: REdgeInsets.symmetric(horizontal: 20)),
              value: dropdownVal,
              items: warehouses,
              onChanged: (value) {
                innerSetState(() {
                  dropdownVal = value!;
                });
              },
            ));
          }),
          SizedBox(height: 10.h),
          Text('Название товара*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            enabled: false,
            controller: nameController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _createArrivalBloc.emit(CreateArrivalInitial());
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
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _createArrivalBloc.add(AddExistArrivalEvent(
                        sku: arrival.product!.sku,
                        warehouseId: dropdownVal,
                        quantity: countController.text,
                        id: arrival.product!.id));
                  },
                  child: const Text('Добавить'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // for non exist product
  Widget buildNonExistModel(
      List<DropdownMenuItem<String>> warehouses, String sku) {
    final countController = TextEditingController();
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    return Container(
      decoration: Decorations.containerDecoration,
      padding: REdgeInsets.all(8),
      margin: REdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Товар не существует, введите необходимые данные нового товара',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 15, color: Colors.black)),
          const Divider(),
          Text('Артикул*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: sku,
              labelStyle: TextStyle(color: Colors.grey[800]),
              filled: true,
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text('Название товара*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text('Стоимость (розничная)*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[800]),
              filled: true,
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text('Количество*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          TextField(
            controller: countController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Введите количество',
              labelStyle: TextStyle(color: Colors.grey[800]),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text('Склад*',
              style: TextStyles.editStyle
                  .copyWith(fontSize: 13, color: Colors.black)),
          SizedBox(height: 5.h),
          StatefulBuilder(builder: (context, innerSetState) {
            return DropdownButtonHideUnderline(
                child: DropdownButton2(
              buttonStyleData: ButtonStyleData(
                  height: 35.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).scaffoldBackgroundColor),
                  padding: REdgeInsets.symmetric(horizontal: 20)),
              value: dropdownVal,
              items: warehouses,
              onChanged: (value) {
                innerSetState(() {
                  dropdownVal = value!;
                });
              },
            ));
          }),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _createArrivalBloc.emit(CreateArrivalInitial());
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
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _createArrivalBloc.add(AddNonExistArrivalEvent(
                        sku: sku,
                        warehouseId: dropdownVal,
                        quantity: countController.text,
                        name: nameController.text,
                        price: priceController.text));
                  },
                  child: const Text('Добавить'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ////////////////////
  Widget buildArrivalCreate() {
    final skuController = TextEditingController();
    return Center(
      child: Container(
        padding: REdgeInsets.all(8),
        margin: REdgeInsets.all(12),
        decoration: Decorations.containerDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Добавление товара',
                style: TextStyles.loginTitle,
              ),
            ),
            const Divider(
              height: 10,
            ),
            const Text(
              'Артикул *',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: skuController,
              decoration: const InputDecoration(
                labelText: 'Введите артикул...',
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                if (skuController.text.trim().isNotEmpty) {
                  _createArrivalBloc
                      .add(CheckExistenceEvent(sku: skuController.text));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 30.h),
              ),
              child: const Text(
                'Поиск',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
