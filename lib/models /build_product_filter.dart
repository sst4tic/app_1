import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/product_filter_model.dart';
import '../util/function_class.dart';
import '../util/styles.dart';

showProductFilter(
    {required BuildContext context,
    required List<ProductFilterModel> filterData,
    Function(String)? onSubmitted,
    required Function(bool) isFilter,
    required String type}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      isScrollControlled: true,
      builder: (context) {
        final searchController = TextEditingController();
        bool filterVal = true;
        return StatefulBuilder(builder: (context, innerSetState) {
          return Container(
            padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                          filterVal = false;
                          if (type == 'all_products') {
                            var data = await Func().getProductsFilters();
                            innerSetState(() {
                              filterData = data;
                            });
                          } else if (type == 'operations') {
                            var data = await Func().getOperationFilters();
                            innerSetState(() {
                              filterData = data;
                            });
                          } else if (type == 'arrival') {
                            var data = await Func().getArrivalFilters();
                            innerSetState(() {
                              filterData = data;
                            });
                          } else if (type == 'moving') {
                            var data = await Func().getMovingFilters();
                            innerSetState(() {
                              filterData = data;
                            });
                          } else if (type == 'users') {
                            var data = await Func().getUserFilters();
                            innerSetState(() {
                              filterData = data;
                            });
                          }
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
                            dropdownSearchData: item.value == 'category_id'
                                ? DropdownSearchData(
                                    searchInnerWidget: Padding(
                                      padding: REdgeInsets.all(8.0),
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey,
                                          ),
                                          hintText: 'Поиск',
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchInnerWidgetHeight: 50,
                                    searchController: searchController,
                                    searchMatchFn: (item, searchValue) {
                                      String itemValue =
                                          item.child.toString().toLowerCase();
                                      String searchValueLower =
                                          searchValue.toLowerCase();
                                      bool containsValue =
                                          itemValue.contains(searchValueLower);
                                      return containsValue;
                                    },
                                  )
                                : null,
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
                    isFilter(filterVal);
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
