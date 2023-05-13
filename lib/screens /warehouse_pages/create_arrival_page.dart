import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/create_arrival_bloc/create_arrival_bloc.dart';
import '../../util/styles.dart';

class CreateArrivalPage extends StatefulWidget {
  const CreateArrivalPage({Key? key}) : super(key: key);

  @override
  State<CreateArrivalPage> createState() => _CreateArrivalPageState();
}

class _CreateArrivalPageState extends State<CreateArrivalPage> {
  final _createArrivalBloc = CreateArrivalBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: BlocProvider<CreateArrivalBloc>(
        create: (context) => CreateArrivalBloc(),
        child: BlocBuilder<CreateArrivalBloc, CreateArrivalState>(
          builder: (context, state) {
            if(state is CreateArrivalInitial) {
              return buildArrivalCreate(createArrivalBloc: _createArrivalBloc);
            } else if(state is ArrivalExist) {
              return const Text('exist');
            } else if(state is ArrivalNotExist) {
              return const Text('NOT exist');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
    );
  }
  Widget buildArrivalCreate({required CreateArrivalBloc createArrivalBloc}) {
    final skuController = TextEditingController();
    return Container(
      padding: REdgeInsets.all(8),
      margin: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text('Добавление товара',
              style: TextStyles.loginTitle,
            ),
          ),
          const Divider(height: 10,),
          const Text('Артикул *', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          SizedBox(height: 5.h),
          TextField(
            controller: skuController,
            decoration: const InputDecoration(
              labelText: 'Введите артикул...',
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(onPressed: () {
            createArrivalBloc.add(CheckExistenceEvent(sku: skuController.text));
          }, style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 30.h),
          ), child: const Text('Поиск', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),),
        ],
      ),
    );
  }
}
