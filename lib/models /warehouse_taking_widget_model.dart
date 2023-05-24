import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
import '../../util/styles.dart';
import '../../util/warehouse_sale.dart';

Widget buildTakingList(
    {required List<Sales> taking,
      required VoidCallback onRefresh
    }) {
  return taking.isNotEmpty ? ListView.builder(
    padding: REdgeInsets.all(8),
    scrollDirection: Axis.vertical,
    itemCount: taking.length,
    itemBuilder: (context, index) {
      final sales = taking[index];
      return Container(
        padding: REdgeInsets.symmetric(horizontal: 12),
        margin: REdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: sales.statusName == 'Отпущено'
              ? Border.all(color: Colors.green, width: 1.5)
              : (sales.statusName == 'Отменено'
                  ? Border.all(color: Colors.red, width: 1.5)
                  : Border.all(color: Colors.transparent)),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '# ${sales.invoiceId}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WareHouseSalesDetails(
                            invoiceId: sales.invoiceId,
                            id: sales.id,
                          ),
                        ),
                      ).then((value) => onRefresh.call());
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).scaffoldBackgroundColor,
                        elevation: 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          'Открыть',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )
                      ],
                    ))
              ],
            ),
            const Divider(
              height: 0,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: REdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  sales.typeName!.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'статус'.toUpperCase(),
              style: TextStyles.editStyle,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: REdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: sales.statusName == 'Отпущено'
                    ? Colors.green[200]
                    : (sales.statusName == 'Отменено'
                        ? Colors.red[200]
                        : Theme.of(context).scaffoldBackgroundColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(sales.statusName!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'канал'.toUpperCase(),
              style: TextStyles.editStyle,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: REdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(sales.saleChannelName ?? 'Канал не указан',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'сотрудник'.toUpperCase(),
              style: TextStyles.editStyle,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: REdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.circle,
                    size: 12,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(sales.managerName!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'адрес'.toUpperCase(),
              style: TextStyles.editStyle,
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: REdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(sales.address!,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
            Center(
              child: Text(
                sales.createdAt!,
                style: TextStyles.editStyle,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      );
    },
  ) : const Center(
    child: Text('Нет накладных для вывоза', style: TextStyles.loginTitle),
  );
}
