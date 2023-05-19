import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/custom_animated_container_model.dart';
import 'package:yiwucloud/screens%20/invoice_scan_page.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/sales_details_bloc/sales_details_bloc.dart';
import '../util/sales_details_model.dart';

class SalesDetailsWidget extends StatefulWidget {
  final SalesDetailsModel salesDetails;
  final int id;
  final String invoiceId;
  final SalesDetailsBloc detailsBloc;

  const SalesDetailsWidget({
    super.key,
    required this.salesDetails,
    required this.id,
    required this.detailsBloc,
    required this.invoiceId,
  });

  @override
  SalesDetailsWidgetState createState() => SalesDetailsWidgetState();
}

class SalesDetailsWidgetState extends State<SalesDetailsWidget> {
  late SalesDetailsModel salesDetails;
  late int id;
  late SalesDetailsBloc detailsBloc;

  @override
  void initState() {
    super.initState();
    salesDetails = widget.salesDetails;
    id = widget.id;
    detailsBloc = widget.detailsBloc;
  }

  bool isDetailsExpanded = false;
  bool isDeliveryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: REdgeInsets.all(8),
      children: [
        salesDetails.btnAct != null
            ? ElevatedButton(
                onPressed: () async {
                  detailsBloc.add(MovingRedirectionEvent(
                      id: id,
                      act: salesDetails.btnAct ?? '',
                      context: context));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 35.h),
                ),
                child: Text(salesDetails.btnText),
              )
            : Container(),
        salesDetails.btnAct != null ? SizedBox(height: 5.h) : Container(),
        salesDetails.status != 5
            ? ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceScanPage(
                                invoiceId: widget.invoiceId,
                                id: id,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 35.h),
                    backgroundColor: Colors.green),
                label: const Text('Сканировать накладную'),
                icon: const Icon(Icons.qr_code_scanner_sharp),
              )
            : Container(),
        salesDetails.status != 5 ? SizedBox(height: 5.h) : Container(),
        salesDetails.boxesPermission
            ? ElevatedButton(
                onPressed: () {
                  detailsBloc.add(ChangeBoxQty(id: id, context: context));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 35.h),
                    backgroundColor: Colors.blue[900]),
                child: Text(
                    'Указать количество мест (${salesDetails.boxesQty ?? '0'})'))
            : Container(),
        SizedBox(height: 10.h),
        CustomAnimatedContainer(
            name: 'Детали',
            onTap: () {
              setState(() {
                isDetailsExpanded = !isDetailsExpanded;
              });
            },
            isExpanded: isDetailsExpanded,
            child: Container(
              padding: REdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Клиент:'),
                      Flexible(
                          child: Text(
                        salesDetails.client.name!,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Менеджер:'),
                      Text(salesDetails.manager.name!),
                    ],
                  ),
                  const Divider(),
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
                  const Divider(),
                  Row(
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
                ],
              ),
            )),
        SizedBox(height: 10.h),
        CustomAnimatedContainer(
          name: 'Детали доставки',
          onTap: () {
            setState(() {
              isDeliveryExpanded = !isDeliveryExpanded;
            });
          },
          isExpanded: isDeliveryExpanded,
          child: Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
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
                    Flexible(
                        child: Text(
                      salesDetails.shipment.shipmentType,
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Адрес доставки:'),
                    Flexible(
                      child: Text(
                        salesDetails.shipment.address,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
        ),
        SizedBox(height: 10.h),
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: REdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Товары'.toUpperCase(),
                style: TextStyles.editStyle,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: salesDetails.products!.length,
              itemBuilder: (context, index) {
                final product = salesDetails.products![index];
                return ListTile(
                  shape: index == salesDetails.products!.length - 1
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ))
                      : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
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
            ),
          ],
        ),
        // CustomAnimatedContainer(
        //   isExpanded: true,
        //   name: 'товары',
        //   onTap: () {
        //   },
        //   child: salesDetails.products != null
        //       ? ListView.separated(
        //     shrinkWrap: true,
        //     physics: const BouncingScrollPhysics(),
        //     itemCount: salesDetails.products!.length,
        //     itemBuilder: (context, index) {
        //       final product = salesDetails.products![index];
        //       return ListTile(
        //         shape: index == salesDetails.products!.length - 1
        //             ? const RoundedRectangleBorder(
        //             borderRadius: BorderRadius.only(
        //               bottomLeft: Radius.circular(8),
        //               bottomRight: Radius.circular(8),
        //             ))
        //             : const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.zero,
        //         ),
        //         title: Text(
        //           product.name,
        //         ),
        //         subtitle: Text(
        //           'Количество: ${product.qty.toString()} | Скидка: ${product
        //               .discount.toString()} %',
        //         ),
        //         trailing: Text(
        //           '${product.price.toString()} ₸',
        //           style: const TextStyle(fontWeight: FontWeight.bold),
        //         ),
        //       );
        //     },
        //     separatorBuilder: (context, index) {
        //       return const Divider(
        //         height: 0,
        //       );
        //     },
        //   )
        //       : const Center(
        //     child: Text('Товары отсутствуют'),
        //   ),
        // ),
        SizedBox(height: 25.h),
      ],
    );
  }
}
