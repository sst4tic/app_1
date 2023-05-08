import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:yiwucloud/models%20/image_list_model.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/product_history.dart';
import 'package:yiwucloud/util/product_details.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final _detailBloc = ProductDetailBloc();
  final _imgList = <String>[
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
  ];
  final _fullImgList = <String>[
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
  ];

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
                return buildProdDetails(state.product);
              } else if (state is ProductDetailLoadingFailure) {
                return Center(
                  child: Text(state.exception.toString()),
                );
              }
              else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ));
  }

  Widget buildProdDetails(ProductDetailsWithWarehouses product) {
    final data = product.data;
    final warehouses = product.warehouses.map((e) => e).toList();
    List<Widget> warehouseTiles = [];
    for (var warehouse in warehouses) {
      warehouseTiles.add(ListTile(
        leading: const Icon(
          Icons.calendar_month,
          size: 35,
          color: Colors.blue,
        ),
        title: Text(
           '${warehouse.count} ${warehouse.name}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Последние изменения: ${warehouse.updatedAt}',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ));
    }
    return ListView(
      padding: REdgeInsets.all(8),
      children: [
       ...warehouseTiles,

        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: REdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Детали товара',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Text('Название: ${data.name}'),
              SizedBox(height: 3.h),
              Text('Цена: ${data.price.toString()}'),
              SizedBox(height: 3.h),
              Text('Артикул: ${data.sku}'),
              SizedBox(height: 3.h),
              Text('Дата добавления: ${data.createdAt}'),
              SizedBox(height: 3.h),
              Text('Описание: ${data.description ?? 'Нет описания'}'),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: REdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Фотографии',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              SizedBox(
                  height: 200,
                  child: ImageList(
                    imageUrls: _imgList,
                    fullImageUrl: _fullImgList,
                  ))
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Container(
            height: 30.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductHistory(logs: data.logs!)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Посмотреть историю действий',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                  )
                ],
              ),
            ))
      ],
    );
  }
}
