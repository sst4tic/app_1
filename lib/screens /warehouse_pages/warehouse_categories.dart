import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/warehouse_categories_bloc/warehouse_categories_bloc.dart';

class WarehouseCategories extends StatefulWidget {
  const WarehouseCategories({Key? key}) : super(key: key);

  @override
  State<WarehouseCategories> createState() => _WarehouseCategoriesState();
}

class _WarehouseCategoriesState extends State<WarehouseCategories> {
  final _categoriesBloc = WarehouseCategoriesBloc();

  @override
  void initState() {
    super.initState();
    _categoriesBloc.add(LoadWarehouseCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Склад: категории'),
      ),
      body: Center(
        child: BlocProvider<WarehouseCategoriesBloc>(
          create: (context) => WarehouseCategoriesBloc(),
          child: BlocBuilder<WarehouseCategoriesBloc, WarehouseCategoriesState>(
            bloc: _categoriesBloc,
            builder: (context, state) {
              if (state is WarehouseCategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WarehouseCategoriesLoaded) {
                return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];
                    final child = state.categories[index].child
                        ?.map((e) => e.name)
                        .toList();
                    return ExpansionTile(
                      title: Text(category.name),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: child?.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(child![index]!),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (state is WarehouseCategoriesError) {
                return Center(
                  child: Text(state.exception.toString()),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
