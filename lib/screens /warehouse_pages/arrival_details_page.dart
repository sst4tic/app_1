import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/styles.dart';

import '../../bloc/arrival_details_bloc/arrival_details_bloc.dart';

class ArrivalDetailsPage extends StatefulWidget {
  const ArrivalDetailsPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<ArrivalDetailsPage> createState() => _ArrivalDetailsPageState();
}

class _ArrivalDetailsPageState extends State<ArrivalDetailsPage> {
  final _detailsBloc = ArrivalDetailsBloc();

  @override
  void initState() {
    super.initState();
    _detailsBloc.add(LoadArrivalDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Приход №${widget.id}'),
        ),
        body: BlocProvider<ArrivalDetailsBloc>(
          create: (context) => ArrivalDetailsBloc(),
          child: BlocBuilder<ArrivalDetailsBloc, ArrivalDetailsState>(
            bloc: _detailsBloc,
            builder: (context, state) {
              if (state is ArrivalDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ArrivalDetailsLoaded) {
                final details = state.arrivalDetails;
                return ListView(
                  children: [
                    Container(
                      padding: REdgeInsets.all(8),
                      margin: REdgeInsets.all(8),
                      decoration: Decorations.containerDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'детали'.toUpperCase(),
                            style: TextStyles.editStyle,
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Менеджер:'),
                              Flexible(child: Text(details.manager)),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Склад:'),
                              Flexible(child: Text(details.warehouse)),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Комментарии:'),
                              Flexible(
                                  child:
                                      Text(details.comments ?? 'Не указано')),
                            ],
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Создано:'),
                              Flexible(child: Text(details.createdAt)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: REdgeInsets.only(
                          left: 8, right: 8, top: 8, bottom: 0),
                      margin: REdgeInsets.all(8),
                      decoration: Decorations.containerDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Товары'.toUpperCase(),
                              style: TextStyles.editStyle),
                          SizedBox(height: 5.h),
                          const Divider(height: 0),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: details.products.length,
                            itemBuilder: (context, index) {
                              final product = details.products[index];
                              return ListTile(
                                title: Text(
                                  product.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                subtitle: Text(
                                  'Количество: ${product.qty.toString()} | Артикул: ${product.sku}',
                                ),
                                trailing: Text(
                                  '${product.price.toString()} ₸',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (state is ArrivalDetailsError) {
                return Center(child: Text(state.e.toString()));
              } else {
                return const Center(child: Text('Error'));
              }
            },
          ),
        ));
  }
}
