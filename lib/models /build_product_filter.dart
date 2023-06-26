import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/product_filter_model.dart';
import 'package:yiwucloud/util/function_class.dart';

import '../util/styles.dart';

showProductFilter({
  required BuildContext context,
  required List<ProductFilterModel> filterData,
  Function(String)? onSubmitted,
}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (context, innerSetState) {
            return Container(
              padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                      const Text(
                        'Фильтр',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            final newData = await Func().getProductsFilters();
                            innerSetState(() {
                              for (var element in filterData) {
                                element.initialValue = newData
                                    .firstWhere((e) => e.name == element.name)
                                    .initialValue;
                              }

                            });
                          },
                          child: const Text(
                            'Сбросить',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: filterData.length,
                    itemBuilder: (context, index) {
                      final item = filterData[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name!.toUpperCase(),
                            style: TextStyles.editStyle,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  padding: REdgeInsets.all(8)),
                              value: item.initialValue,
                              items: item.childData
                                  .map((e) => DropdownMenuItem(
                                        value: e.value,
                                        child: Text(e.text),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                innerSetState(() {
                                  item.initialValue = value!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      );
                    },
                  ),
                 const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      final filter = filterData
                          .map((e) => '${e.value}=${e.initialValue}')
                          .join('&');
                      onSubmitted!(filter);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40)),
                    child: const Text('Применить'),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            );
          });
        });
}
