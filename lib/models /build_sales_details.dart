import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';
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

  final Set<int> _isLoading = {};

  void _onSubmit(int index) {
    setState(() {
      if (_isLoading.contains(index)) {
        _isLoading.remove(index);
      } else {
        _isLoading.add(index);
      }
    });
  }

  bool isDetailsExpanded = false;
  bool isDeliveryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: REdgeInsets.all(8),
      children: [
        salesDetails.isPostponed
            ? Container(
                padding: REdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.yellow[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.yellow[900],
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Накладная отложена',
                      style: TextStyle(color: Colors.yellow[900]),
                    ),
                  ],
                ),
              )
            : Container(),
        SizedBox(height: salesDetails.btnAct != null ? 5.h : 0),
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
        salesDetails.btnScan != false || salesDetails.btnBoxes != false
            ? ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceScanPage(
                                invoiceId: widget.invoiceId,
                                id: id,
                              ))).then(
                      (value) => detailsBloc.add(LoadSalesDetails(id: id)));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 35.h),
                    backgroundColor: Colors.green),
                label: Text(salesDetails.btnScan
                    ? 'Сканировать товары'
                    : 'Сканировать коробки'),
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
        Container(
          padding: REdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: salesDetails.status == 5
                ? Colors.green[200]
                : salesDetails.status == 6
                    ? Colors.red[200]
                    : Theme.of(context).primaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Статус: ${salesDetails.statusName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              salesDetails.courierName != null
                  ? Text(
                      'Курьер: ${salesDetails.courierName!}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
              salesDetails.assemblerName != null
                  ? Text(
                      'Сборщик: ${salesDetails.assemblerName!}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Accordion(
          disableScrolling: true,
          paddingListHorizontal: 0,
          paddingListBottom: 0,
          paddingListTop: 0,
          children: [
            AccordionSection(
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                sectionOpeningHapticFeedback: SectionHapticFeedback.light,
                rightIcon: isDeliveryExpanded
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_arrow_down),
                header: Text(
                  'детали'.toUpperCase(),
                  style: TextStyles.editStyle,
                ),
                content: Container(
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
                            salesDetails.client.name ?? 'Клиент не указан',
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Номер телефона:'),
                          Flexible(
                              child: salesDetails.client.phone != null
                                  ? RichText(
                                      text: TextSpan(
                                        text: salesDetails.client.phone,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            launchUrlString(
                                                'tel://${salesDetails.client.phone}');
                                          },
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : const Text('Не указано')),
                        ],
                      ),
                      salesDetails.contacts != null
                          ? Column(
                              children: salesDetails.contacts!
                                  .map((e) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Номер телефона ${salesDetails.contacts!.indexOf(e) + 1}'),
                                          Text(e),
                                        ],
                                      ))
                                  .toList(),
                            )
                          : Container(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Менеджер:'),
                          Text(salesDetails.manager.name ?? 'Не указано'),
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
                          Text(salesDetails.details.servicePoint ??
                              'Не указано'),
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
                      salesDetails.details.kaspiNum != null
                          ? const Divider()
                          : const SizedBox(),
                      salesDetails.details.kaspiNum != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Заявка kaspi:'),
                                Text('${salesDetails.details.kaspiNum}'),
                              ],
                            )
                          : const SizedBox(),
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
                ))
          ],
        ),
        Accordion(
            disableScrolling: true,
            paddingListHorizontal: 0,
            paddingListBottom: 0,
            paddingListTop: 0,
            children: [
              AccordionSection(
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                sectionOpeningHapticFeedback: SectionHapticFeedback.light,
                header: Text('детали доставки'.toUpperCase(),
                    style: TextStyles.editStyle),
                rightIcon: isDeliveryExpanded
                    ? const Icon(Icons.keyboard_arrow_up)
                    : const Icon(Icons.keyboard_arrow_down),
                content: Container(
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
                          const Text('Дата отгрузки:'),
                          Text(salesDetails.shipment.date ?? 'Не указано'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Страна:'),
                          Text(salesDetails.country ?? 'Страна не указана'),
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
                          const Text('Срочная доставка:'),
                          Text(salesDetails.shipment.urgency),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Адрес доставки:'),
                        ],
                      ),
                      Text(
                        salesDetails.shipment.address,
                      ),
                    ],
                  ),
                ),
              )
            ]),
        SizedBox(height: 5.h),
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
                final availabilityString = product.availability
                        ?.where((item) => item.location != '')
                        .map((item) => '${item.name} | ${item.location}')
                        .join('\n') ??
                    'Нет в наличии';
                return ListTile(
                  onTap: () {
                    availabilityString != '' ? _onSubmit(index) : null;
                  },
                  shape: index == salesDetails.products!.length - 1
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        )
                      : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: _isLoading.contains(index),
                        child: Text(
                          availabilityString,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                    ],
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
        SizedBox(height: 25.h),
      ],
    );
  }
}
