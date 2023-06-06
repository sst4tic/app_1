
// showFilter(
//         {required BuildContext context,
//         required FilterModel filterData,
//         bloc}) =>
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       isScrollControlled: true,
//       builder: (context) {
//         final searchController = TextEditingController();
        // ////////////
        // final statusItems = filterData.status!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var initialStatusVal = filterData.status!.initialValue;
        // //////////////
        // final invoiceItems = filterData.typeOfInvoice!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var invoiceInitialVal = filterData.typeOfInvoice!.initialValue;
        // /////////////
        // final paymentItems = filterData.paymentsMethod!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var paymentInitialVal = filterData.paymentsMethod!.initialValue;
        // ////////////
        // final shipmentItems = filterData.shipmentType!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var shipmentInitialVal = filterData.shipmentType!.initialValue;
        // ////////////
        // final discountItems = filterData.discount!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var discountInitialVal = filterData.discount!.initialValue;
        // ////////////
        // final saleChannelItems = filterData.saleChannel!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var saleChannelInitialVal = filterData.saleChannel!.initialValue;
        // ////////////
        // final billItems = filterData.bill!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var billInitialVal = filterData.bill!.initialValue;
        // ////////////
        // final warehouseItems = filterData.servicePoint!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // ////////////
        // final servicePointItems = filterData.servicePoint!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var servicePointInitialVal = filterData.servicePoint!.initialValue;
        // ////////////
        // final shipmentPointItems = filterData.shipmentPoint!.childData
        //     .map((e) => DropdownMenuItem(
        //           value: e.value,
        //           child: Text(e.text),
        //         ))
        //     .toList();
        // var shipmentPointInitialVal = filterData.shipmentPoint!.initialValue;
        // ////////////
        // var withDocsInitialVal = filterData.withDocs!.initialValue;
        // ////////////
        // final TextEditingController dateController = TextEditingController();
        // Future<void> _selectDate(BuildContext context) async {
        //   final DateTimeRange? picked = await showDateRangePicker(
        //     saveText: 'Сохранить',
        //     cancelText: 'Отмена',
        //     helpText: 'Выберите дату',
        //     fieldEndLabelText: 'Конец',
        //     fieldStartLabelText: 'Начало',
        //     context: context,
        //     builder: (BuildContext context, Widget? child) {
        //       return Theme(
        //         data: ThemeData.light().copyWith(
        //           colorScheme: const ColorScheme.light(
        //             primary: Colors.blue,
        //             onPrimary: Colors.white,
        //             onSurface: Colors.black,
        //           ),
        //           dialogBackgroundColor: Colors.white,
        //         ),
        //         child: child!,
        //       );
        //     },
        //     firstDate: DateTime(2021),
        //     lastDate: DateTime.now(),
        //     initialDateRange: DateTimeRange(
        //       start: DateTime.now().subtract(const Duration(days: 30)),
        //       end: DateTime.now(),
        //     ),
        //   );
        //   if (picked != null) {
        //     final pickedDate =
        //         '${picked.start.toString().substring(0, 10)} - ${picked.end.toString().substring(0, 10)}';
        //     final AmanDate =
        //         '${picked.start.toString().substring(0, 10)}/${picked.end.toString().substring(0, 10)}';
        //     dateController.text = pickedDate;
        //   }
        // }
        ////////////////
        // return StatefulBuilder(builder: (context, innerSetState) {
        //   return Container(
        //     padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
        //     height: MediaQuery.of(context).size.height * 0.8,
        //     child: ListView(
        //       children: [
        //         Row(
        //           children: [
        //             Text(
        //               'Фильтр',
        //               style: TextStyles.bodyStyle,
        //             ),
        //             const Spacer(),
        //             IconButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 },
        //                 icon: const Icon(Icons.close)),
        //           ],
        //         ),
        //         SizedBox(height: 10.h),
        //         TextField(
        //           controller: searchController,
        //           decoration: const InputDecoration(
        //             hintText: 'Поиск',
        //             hintStyle: TextStyle(color: Colors.grey),
        //             prefixIcon: Icon(
        //               Icons.search,
        //               color: Colors.grey,
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: 10.h),
                // Text(
                //   filterData.status!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.status!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: initialStatusVal,
                //     items: statusItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         initialStatusVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.typeOfInvoice!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.typeOfInvoice!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: invoiceInitialVal,
                //     items: invoiceItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         invoiceInitialVal = value.toString();
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.dateOther!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // TextField(
                //   controller: dateController,
                //   readOnly: true,
                //   onTap: () async {
                //     // show cupertino date picker
                //     await _selectDate(context);
                //   },
                //   decoration: const InputDecoration(
                //     hintText: 'Выберите дату',
                //     hintStyle: TextStyle(color: Colors.grey),
                //     suffixIcon: Icon(Icons.calendar_today_outlined),
                //   ),
                // ),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.dateCompleted!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // TextField(
                //   controller: dateController,
                //   readOnly: true,
                //   onTap: () async {
                //     await _selectDate(context);
                //   },
                //   decoration: const InputDecoration(
                //     hintText: 'Выберите дату',
                //     hintStyle: TextStyle(color: Colors.grey),
                //     suffixIcon: Icon(Icons.calendar_today_outlined),
                //   ),
                // ),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.dateCanceled!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // TextField(
                //   controller: dateController,
                //   readOnly: true,
                //   onTap: () async {
                //     await _selectDate(context);
                //   },
                //   decoration: const InputDecoration(
                //     hintText: 'Выберите дату',
                //     hintStyle: TextStyle(color: Colors.grey),
                //     suffixIcon: Icon(Icons.calendar_today_outlined),
                //   ),
                // ),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.dateReturned!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // TextField(
                //   controller: dateController,
                //   readOnly: true,
                //   onTap: () async {
                //     await _selectDate(context);
                //   },
                //   decoration: const InputDecoration(
                //     hintText: 'Выберите дату',
                //     hintStyle: TextStyle(color: Colors.grey),
                //     suffixIcon: Icon(Icons.calendar_today_outlined),
                //   ),
                // ),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.paymentsMethod!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.paymentsMethod!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: paymentInitialVal,
                //     items: paymentItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         paymentInitialVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.shipmentType!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.shipmentType!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: shipmentInitialVal,
                //     items: shipmentItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         shipmentInitialVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.discount!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.discount!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: discountInitialVal,
                //     items: discountItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         discountInitialVal = value.toString();
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.saleChannel!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.saleChannel!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: saleChannelInitialVal,
                //     items: saleChannelItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         saleChannelInitialVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.bill!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.bill!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: billInitialVal,
                //     items: billItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         billInitialVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.servicePoint!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.servicePoint!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: servicePointInitialVal,
                //     items: servicePointItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         servicePointInitialVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.shipmentPoint!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // if (filterData.shipmentPoint!.type == 'select')
                //   DropdownButtonHideUnderline(
                //       child: DropdownButton2(
                //     isExpanded: true,
                //     buttonStyleData: ButtonStyleData(
                //         height: 50,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(8),
                //             color: Theme.of(context).scaffoldBackgroundColor),
                //         padding: REdgeInsets.all(8)),
                //     value: shipmentPointInitialVal,
                //     items: shipmentPointItems,
                //     hint: const Text('Выберите статус'),
                //     onChanged: (value) {
                //       innerSetState(() {
                //         shipmentPointInitialVal = int.parse(value.toString());
                //       });
                //     },
                //   )),
                // SizedBox(height: 10.h),
                // Text(
                //   filterData.withDocs!.name.toUpperCase(),
                //   style: TextStyles.editStyle,
                // ),
                // SizedBox(height: 10.h),
                // // create radio for withDocs
                // if (filterData.withDocs!.type == 'radio')
                //   Column(
                //     children: [
                //       Row(
                //         children: [
                //           Radio(
                //             value: 1,
                //             groupValue: withDocsInitialVal,
                //             onChanged: (value) {
                //               innerSetState(() {
                //                 withDocsInitialVal = value.toString();
                //               });
                //             },
                //           ),
                //           Text(
                //             'Да',
                //             style: TextStyles.editStyle,
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Radio(
                //             value: 0,
                //             groupValue: withDocsInitialVal,
                //             onChanged: (value) {
                //               innerSetState(() {
                //                 withDocsInitialVal = value.toString();
                //               });
                //             },
                //           ),
                //           Text(
                //             'Нет',
                //             style: TextStyles.editStyle,
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
    //             const Spacer(),
    //             ElevatedButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                   if (bloc is WarehouseSalesBloc) {
    //                     bloc!.add(
    //                         LoadWarehouseSales(query: searchController.text));
    //                   } else if (bloc is ProductsBloc) {
    //                     bloc!.add(LoadProducts(query: searchController.text));
    //                   }
    //                 },
    //                 child: const Text('Применить')),
    //           ],
    //         ),
    //       );
    //     });
    //   },
    // );
