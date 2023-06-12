import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../util/filter_list_model.dart';
import '../util/styles.dart';

showFilter(
        {required BuildContext context,
        required FilterModel filterData,
        Function(String)? onSubmitted
        }) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) {
        final shipmentItems = filterData.shipmentType!.childData
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.text),
                ))
            .toList();
        var shipmentInitialVal = filterData.shipmentType!.initialValue;
        ////////////
        final saleChannelItems = filterData.saleChannel!.childData
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.text),
                ))
            .toList();
        var saleChannelInitialVal = filterData.saleChannel!.initialValue;
        ////////////
        final shipmentPointItems = filterData.shipmentPoint!.childData
            .map((e) => DropdownMenuItem(
                  value: e.value,
                  child: Text(e.text),
                ))
            .toList();
        var shipmentPointInitialVal = filterData.shipmentPoint!.initialValue;
        //////////////
        return StatefulBuilder(builder: (context, innerSetState) {
          return Container(
            padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Фильтр',
                      style: TextStyles.bodyStyle,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  filterData.saleChannel!.name.toUpperCase(),
                  style: TextStyles.editStyle,
                ),
                SizedBox(height: 10.h),
                if (filterData.saleChannel!.type == 'select')
                  DropdownButtonHideUnderline(
                      child: DropdownButton2(
                    isExpanded: true,
                    buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        padding: REdgeInsets.all(8)),
                    value: saleChannelInitialVal,
                    items: saleChannelItems,
                    hint: const Text('Выберите статус'),
                    onChanged: (value) {
                      innerSetState(() {
                        saleChannelInitialVal = int.parse(value.toString());
                      });
                    },
                  )),
                SizedBox(height: 10.h),
                Text(
                  filterData.shipmentType!.name.toUpperCase(),
                  style: TextStyles.editStyle,
                ),
                SizedBox(height: 10.h),
                if (filterData.shipmentType!.type == 'select')
                  DropdownButtonHideUnderline(
                      child: DropdownButton2(
                    isExpanded: true,
                    buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        padding: REdgeInsets.all(8)),
                    value: shipmentInitialVal,
                    items: shipmentItems,
                    hint: const Text('Выберите статус'),
                    onChanged: (value) {
                      innerSetState(() {
                        shipmentInitialVal = int.parse(value.toString());
                      });
                    },
                  )),
                SizedBox(height: 10.h),
                Text(
                  filterData.shipmentPoint!.name.toUpperCase(),
                  style: TextStyles.editStyle,
                ),
                SizedBox(height: 10.h),
                if (filterData.shipmentPoint!.type == 'select')
                  DropdownButtonHideUnderline(
                      child: DropdownButton2(
                    isExpanded: true,
                    buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        padding: REdgeInsets.all(8)),
                    value: shipmentPointInitialVal,
                    items: shipmentPointItems,
                    hint: const Text('Выберите статус'),
                    onChanged: (value) {
                      innerSetState(() {
                        shipmentPointInitialVal = int.parse(value.toString());
                      });
                    },
                  )),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      innerSetState(() {
                        saleChannelInitialVal =
                            filterData.saleChannel!.initialValue;
                        shipmentInitialVal =
                            filterData.shipmentType!.initialValue;
                        shipmentPointInitialVal =
                            filterData.shipmentPoint!.initialValue;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 40)),
                    child: const Text('Сбросить')),
                ElevatedButton(
                    onPressed: () {
                      final filter = {
                        filterData.saleChannel!.value: saleChannelInitialVal,
                        filterData.shipmentType!.value: shipmentInitialVal,
                        filterData.shipmentPoint!.value:
                            shipmentPointInitialVal,
                      };
                      final apiFilter = filter.entries
                          .map((e) => '${e.key}=${e.value}')
                          .join('&');
                      onSubmitted!(apiFilter);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40)),
                    child: const Text('Применить')),
                SizedBox(height: 10.h),
              ],
            ),
          );
        });
      },
    );
