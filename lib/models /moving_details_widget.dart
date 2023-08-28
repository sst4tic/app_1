import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/moving_details.dart';
import 'package:yiwucloud/util/styles.dart';
import '../bloc/moving_details_bloc/moving_details_bloc.dart';

class MovingDetailsWidget extends StatefulWidget {
  final MovingDetailsModel salesDetails;
  final int id;
  final String invoiceId;
  final MovingDetailsBloc detailsBloc;

  const MovingDetailsWidget({
    super.key,
    required this.salesDetails,
    required this.id,
    required this.detailsBloc,
    required this.invoiceId,
  });

  @override
  MovingDetailsWidgetState createState() => MovingDetailsWidgetState();
}

class MovingDetailsWidgetState extends State<MovingDetailsWidget> {
  late MovingDetailsModel movingDetails;
  late int id;
  late MovingDetailsBloc detailsBloc;
  List<DropdownMenuItem>? dropdownMenuItems;
  int? selectedVal;

  @override
  void initState() {
    super.initState();
    movingDetails = widget.salesDetails;
    id = widget.id;
    detailsBloc = widget.detailsBloc;
    dropdownMenuItems = movingDetails.couriers?.data
        .map((e) => DropdownMenuItem(
              value: e.value,
              child: Text(e.text),
            ))
        .toList();
    selectedVal = movingDetails.couriers?.initialValue;
  }

  bool isDeliveryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: REdgeInsets.all(8),
      children: [
        SizedBox(height: movingDetails.btnAct != null ? 5.h : 0),
        movingDetails.btnAct != null
            ? ElevatedButton(
                onPressed: () async {
                  detailsBloc.add(MovingRedirectionEvent(
                      id: id,
                      act: movingDetails.btnAct ?? '',
                      context: context));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 35.h),
                ),
                child: Text(movingDetails.btnText!),
              )
            : const SizedBox(),
        SizedBox(height: movingDetails.btnBoxes != false ? 5.h : 0),
        movingDetails.btnBoxes != false
            ? ElevatedButton(
                onPressed: () {
                  detailsBloc.add(ChangeBoxQty(
                      id: id,
                      context: context,
                      select: movingDetails.btnBoxesSelectStatus));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 35.h),
                    backgroundColor: Colors.blue[900]),
                child: const Text('Указать количество мест'),
              )
            : const SizedBox(),
        SizedBox(height: dropdownMenuItems != null ? 5.h : 0),
        dropdownMenuItems != null
            ? Text(
                'выберите курьера'.toUpperCase(),
                style: TextStyles.editStyle,
              )
            : const SizedBox(),
        SizedBox(height: dropdownMenuItems != null ? 5.h : 0),
        dropdownMenuItems != null
            ? DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text(
                    'Выберите курьера',
                    style: TextStyle(color: Colors.black),
                  ),
                  isExpanded: true,
                  value: selectedVal,
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    padding: REdgeInsets.all(8),
                  ),
                  items: dropdownMenuItems,
                  onChanged: (value) {
                    if (value != selectedVal!) {
                      setState(() {
                        selectedVal = value;
                      });
                      detailsBloc.add(DefineCourierEvent(
                          invoiceId: id, courierId: value, context: context));
                    }
                  },
                ),
              )
            : Container(),
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
                          const Text('Откуда:'),
                          Text(movingDetails.warehouseFromData),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Куда:'),
                          Text(movingDetails.warehouseToData),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Создал:'),
                          Text(movingDetails.senderData),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Тип перемещения:'),
                          Text(movingDetails.type),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Место сборщик:'),
                          Text(movingDetails.boxesWait != null
                              ? movingDetails.boxesWait.toString()
                              : 'Не указано'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Место логист:'),
                          Text(movingDetails.boxesSent != null
                              ? movingDetails.boxesSent.toString()
                              : 'Не указано'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Место принимающий:'),
                          Text(movingDetails.boxesRecd != null
                              ? movingDetails.boxesRecd.toString()
                              : 'Не указано'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Дата оформления:'),
                          Text(movingDetails.createdAt),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Комментарии:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            movingDetails.comments ?? 'Нет комментариев',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
        SizedBox(height: 8.h),
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
              itemCount: movingDetails.products.length,
              itemBuilder: (context, index) {
                final product = movingDetails.products[index];
                return ListTile(
                  shape: index == movingDetails.products.length - 1
                      ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        )
                      : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                  title: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Количество: ${product.qty.toString()}',
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
