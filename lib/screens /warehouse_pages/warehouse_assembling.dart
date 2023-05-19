import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/warehouse_taking_widget_model.dart';

import '../../bloc/warehouse_assembly_bloc/warehouse_assembly_bloc.dart';

class WarehouseAssembly extends StatefulWidget {
  const WarehouseAssembly({Key? key}) : super(key: key);

  @override
  State<WarehouseAssembly> createState() => _WarehouseAssemblyState();
}

class _WarehouseAssemblyState extends State<WarehouseAssembly> {
  final _assemblyBloc = WarehouseAssemblyBloc();

  @override
  void initState() {
    super.initState();
    _assemblyBloc.add(LoadWarehouseAssembly());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Склад: Сборка'),
      ),
      body: BlocProvider<WarehouseAssemblyBloc>(
        create: (context) => WarehouseAssemblyBloc(),
        child: BlocBuilder<WarehouseAssemblyBloc, WarehouseAssemblyState>(
          bloc: _assemblyBloc,
          builder: (context, state) {
            if(state is WarehouseAssemblyLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WarehouseAssemblyLoaded) {
              return buildTakingList(
                  taking: state.warehouseAssembly,
                  onRefresh: () => context.read<WarehouseAssemblyBloc>().add(LoadWarehouseAssembly()));
            } else {
              return const Center(child: Text('Ошибка'));
            }
          },
        ),
      )
    );
  }
}
