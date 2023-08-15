import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
import 'package:yiwucloud/util/function_class.dart';
import '../bloc/product_detail_bloc/product_detail_bloc.dart';
import '../screens /warehouse_pages/product_history.dart';
import '../util/product_details.dart';
import '../util/styles.dart';
import 'image_list_model.dart';

Widget buildProdDetails(
    ProductDetailsWithWarehouses product, BuildContext context, ProductDetailBloc bloc, items, String val) {
  final imgList = product.data.media.map((e) => e.thumbnails.s350.toString()).toList();
  final fullImgList = product.data.media.map((e) => e.full.toString()).toList();
  const noImage =
      'https://cdn.yiwumart.org/storage/warehouse/products/images/no-image-ru.jpg';
  final data = product.data;
  final warehouses = product.warehouses.map((e) => e).toList();
  return ListView(
    padding: REdgeInsets.all(8),
    children: [
      product.data.availability != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange[400]!, width: 1),
              ),
              padding: REdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Наличие',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  product.data.availability!.list.isEmpty
                      ? const Text('Нет в наличии')
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final warehouse = warehouses[index];
                            final availability =
                                product.data.availability!.list[index];
                            return ListTile(
                              title: Text(
                                availability.name!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Локация: ${warehouse.location ?? 'Не указано'}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),
                              trailing: data.editPermission
                                  ? IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        bloc.add(ChangeLocation(
                                            location: warehouse.location ?? '',
                                            productId: data.id,
                                            warehouseId: warehouse.id,
                                            context: context));
                                      },
                                    )
                                  : null,
                            );
                          },
                          itemCount: product.data.availability!.list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const Divider(height: 0))
                ],
              ),
            )
          : Container(),
      SizedBox(height: 10.h),
      product.data.inSale != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[800]!, width: 1),
              ),
              padding: REdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'В продаже',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                     DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                  buttonStyleData: ButtonStyleData(
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      padding: REdgeInsets.all(8)),
                                  items: items,
                                  value: val,
                                  onChanged: (value) {
                                      val = value.toString();
                                    bloc.add(ChangeWarehouseInSale(warehouseId: int.parse(value.toString()), productId: product.data.id, context: context));
                                  })
                      )
                    ],
                  ),
                  const Divider(),
                  ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final inSale = product.data.inSale!.list[index];
                        return ListTile(
                          title: Text(
                            inSale.name!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            inSale.qty.toString(),
                            style: TextStyles.editStyle.copyWith(fontSize: 14),
                          ),
                        );
                      },
                      itemCount: product.data.inSale!.list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0))
                ],
              ),
            )
          : Container(),
      SizedBox(height: 10.h),
      product.data.availability != null
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1),
              ),
              padding: REdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Предзаказ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  product.data.preorders!.list.isEmpty
                      ? const Text('Нет предзаказов')
                      : ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final preorder =
                                product.data.preorders!.list[index];
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WareHouseSalesDetails(
                                                id: preorder.id!,
                                                invoiceId:
                                                    preorder.invoiceId!)));
                              },
                              title: Text(
                                preorder.invoiceId!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                preorder.qty.toString(),
                                style:
                                    TextStyles.editStyle.copyWith(fontSize: 14),
                              ),
                            );
                          },
                          itemCount: product.data.preorders!.list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              const Divider(height: 0))
                ],
              ),
            )
          : Container(),
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
                            logs: logs,
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
