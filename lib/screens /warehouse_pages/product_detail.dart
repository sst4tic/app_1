import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/product_detail_bloc/product_detail_bloc.dart';
import '../../models /build_details_model.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _detailBloc = ProductDetailBloc();
  @override
  void initState() {
    super.initState();
    _detailBloc.add(LoadProductDetail(id: widget.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
          child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
            bloc: _detailBloc,
            builder: (context, state) {
              if (state is ProductDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductDetailLoaded) {
                return buildProdDetails(state.product, context, _detailBloc, state.warehouses, state.value);
              } else if (state is ProductDetailLoadingFailure) {
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
        ));
  }
}
