import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/sales_details_bloc/sales_details_bloc.dart';
import '../util/sales_details_model.dart';
import '../util/styles.dart';

Widget buildDetails(
    {required SalesDetailsModel salesDetails,
    required BuildContext context,
    required int id,
    required SalesDetailsBloc detailsBloc}) {
  return ListView(
    padding: REdgeInsets.all(8),
    children: [
      ElevatedButton(
        onPressed: () {
          detailsBloc.add(MovingRedirectionEvent(
              id: id, act: salesDetails.btnAct ?? '', context: context));
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 35.h),
        ),
        child: Text(salesDetails.btnText),
      ),
      SizedBox(height: 5.h),
      Container(
        margin: REdgeInsets.all(4),
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              width: 0.4.sw,
              child: ListTile(
                title: Text('Клиент: ${salesDetails.client.name!}'),
                subtitle: const Text('\nРоль: клиент'),
              ),
            ),
            Container(
              width: 0.4.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: ListTile(
                title: Text('Менеджер: ${salesDetails.manager.name}'),
                subtitle: Text(
                  'Роль: ${salesDetails.manager.role}',
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        'Детали'.toUpperCase(),
        style: TextStyles.editStyle,
      ),
      SizedBox(height: 5.h),
      Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Канал продаж:'),
                Text(salesDetails.details.saleChannelName),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Метод оплаты :'),
                Text(salesDetails.details.paymentsMethodName),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Предоплата :'),
                Text(salesDetails.details.prepayment),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Точка обслуживания:'),
                Text(salesDetails.details.servicePoint),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('С документами:'),
                Text(salesDetails.details.withDocs),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Cкидка:'),
                Text('${salesDetails.details.discountName} %'),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        'Детали доставки'.toUpperCase(),
        style: TextStyles.editStyle,
      ),
      SizedBox(height: 5.h),
      Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Точка отгрузки:'),
                Text(salesDetails.shipment.shipmentPoint),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Метод доставки:'),
                Text(salesDetails.shipment.shipmentType),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Адрес доставки:'),
                Text(salesDetails.shipment.address),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Срочная доставка:'),
                Text(salesDetails.shipment.urgency),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        'Товары'.toUpperCase(),
        style: TextStyles.editStyle,
      ),
      SizedBox(height: 5.h),
      salesDetails.products != null
          ? ListView.separated(
              padding: REdgeInsets.all(0),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: salesDetails.products!.length,
              itemBuilder: (context, index) {
                final product = salesDetails.products![index];
                return ListTile(
                  title: Text(
                    product.name,
                  ),
                  subtitle: Text(
                    'Количество: ${product.qty.toString()} | Скидка: ${product.discount.toString()} %',
                  ),
                  trailing: Text(
                    '${product.price.toString()} ₸',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 0,
                );
              },
            )
          : const Center(
              child: Text('Товары отсутствуют'),
            ),
      SizedBox(height: 10.h),
      Container(
        padding: REdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Итого:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${salesDetails.totalPrice} ₸',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      SizedBox(height: 25.h),
    ],
  );
}
