

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/function_class.dart';

import '../screens /warehouse_pages/product_history.dart';
import '../util/product_details.dart';
import 'image_list_model.dart';

Widget buildProdDetails(ProductDetailsWithWarehouses product, BuildContext context) {
  final imgList = <String>[
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/350_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
  ];
  final fullImgList = <String>[
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
    'https://cdn.yiwumart.org/storage/warehouse/products/images/9674/750_g70Ij5PEVuECZZjG4jHUdBnC6JyJVA48U6Upc19C.jpg',
  ];
  final data = product.data;
  final warehouses = product.warehouses.map((e) => e).toList();
  List<Widget> warehouseTiles = [];
  for (var warehouse in warehouses) {
    warehouseTiles.addAll([
      ListTile(
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
      ),
      SizedBox(height: 7.h),
    ]);
  }
  return ListView(
    padding: REdgeInsets.all(8),
    children: [
      ...warehouseTiles.isEmpty ? [] : [...warehouseTiles],
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
                  imageUrls: imgList,
                  fullImageUrl: fullImgList,
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
            onPressed: () async {
             final logs = await Func().loadWarehousesList();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductHistory(logs: logs['data'], prodId: data.id,)));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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