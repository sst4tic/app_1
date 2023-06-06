import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/function_class.dart';

import '../bloc/product_detail_bloc/product_detail_bloc.dart';
import '../screens /warehouse_pages/product_history.dart';
import '../util/product_details.dart';
import 'image_list_model.dart';

Widget buildProdDetails(
    ProductDetailsWithWarehouses product, BuildContext context, ProductDetailBloc bloc) {
  final imgList = product.data.media.map((e) => e.thumbnails.s350.toString()).toList();
  final fullImgList = product.data.media.map((e) => e.full.toString()).toList();
  const noImage = 'https://cdn.yiwumart.org/storage/warehouse/products/images/no-image-ru.jpg';
  final data = product.data;
  final warehouses = product.warehouses.map((e) => e).toList();
  List<Widget> warehouseTiles = [];
  for (var warehouse in warehouses) {
    warehouseTiles.addAll([
      ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.warehouse,
            size: 25,
            color: Colors.white,
          ),
        ),
        title: Text(
          '${warehouse.name} - ${warehouse.count}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Локация: ${warehouse.location ?? 'Не указано'}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: data.editPermission ? IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            bloc.add(ChangeLocation(location: warehouse.location ?? '', productId: data.id, warehouseId: warehouse.id, context: context));
          },
        ) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:  BorderSide(color: Colors.blue[200]!, width: 1),
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
                  imageUrls: imgList.isEmpty ? [noImage] : imgList,
                  fullImageUrl: fullImgList.isEmpty ? [noImage] : fullImgList,
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
              // ignore: use_build_context_synchronously
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductHistory(
                            logs: logs['data'],
                            prodId: data.id,
                          )));
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
