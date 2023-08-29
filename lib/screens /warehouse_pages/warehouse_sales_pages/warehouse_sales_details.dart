import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/sales_comments_page.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/sales_details_chronology.dart';
import 'package:yiwucloud/util/sales_details_model.dart';
import '../../../bloc/sales_details_bloc/sales_details_bloc.dart';
import '../../../models /build_sales_details.dart';
import '../../invoice_edit_page.dart';
import '../../sales_operation_page.dart';

class WareHouseSalesDetails extends StatefulWidget {
  const WareHouseSalesDetails({
    Key? key,
    required this.id,
    required this.invoiceId,
  }) : super(key: key);
  final int id;
  final String invoiceId;

  @override
  State<WareHouseSalesDetails> createState() => _WareHouseSalesDetailsState();
}

class _WareHouseSalesDetailsState extends State<WareHouseSalesDetails> {
  final _detailsBloc = SalesDetailsBloc();
  String printUrl = '';
  String? barcodeBoxesUrl;
  String? barcodeProductsUrl;

  @override
  void initState() {
    super.initState();
    _detailsBloc.add(LoadSalesDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SalesDetailsBloc>(
      create: (context) => SalesDetailsBloc(),
      child: BlocBuilder<SalesDetailsBloc, SalesDetailsState>(
        bloc: _detailsBloc,
        builder: (context, state) {
          if (state is SalesDetailsLoading) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state is SalesDetailsLoaded) {
            printUrl = state.salesDetails.printUrl;
            barcodeBoxesUrl = state.salesDetails.printBarcodeBox;
            barcodeProductsUrl = state.salesDetails.printBarcodeProduct;
            return Scaffold(
              appBar: AppBar(
                title: Text('Накладная № ${widget.invoiceId}'),
                actions: [
                  state.salesDetails.btnSheet
                      ? IconButton(
                          onPressed: () {
                            bottomSheet(
                              salesDetails: state.salesDetails,
                              boxesQty: state.salesDetails.boxesQty ?? 0,
                            );
                          },
                          icon: const Icon(Icons.more_horiz),
                        )
                      : const SizedBox(),
                ],
              ),
              body: SalesDetailsWidget(
                salesDetails: state.salesDetails,
                invoiceId: widget.invoiceId,
                id: widget.id,
                detailsBloc: _detailsBloc,
              ),
            );
          } else if (state is SalesDetailsLoadingFailure) {
            return const Scaffold(body: Center(child: Text('Ошибка сервера')));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  bottomSheet({required SalesDetailsModel salesDetails, boxesQty}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: REdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const Text(
                'Дополнительные действия',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              if (salesDetails.btnChronology)
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsChronology(id: widget.id, isSales: true),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хронология'),
                        Icon(FontAwesomeIcons.codeBranch)
                      ],
                    )),
              SizedBox(height: 3.h),
              if (salesDetails.btnPrint)
                ElevatedButton(
                    onPressed: () {
                      launchUrlString(printUrl,
                          mode: LaunchMode.externalApplication);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Печать накладной'),
                        Icon(FontAwesomeIcons.print)
                      ],
                    )),
              SizedBox(height: 3.h),
              if (barcodeProductsUrl != null)
                ElevatedButton(
                    onPressed: () {
                      launchUrlString(barcodeProductsUrl!,
                          mode: LaunchMode.externalApplication);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Печать баркода товаров'),
                        Icon(FontAwesomeIcons.barcode)
                      ],
                    )),
              SizedBox(height: 3.h),
              if (barcodeBoxesUrl != null)
                ElevatedButton(
                  onPressed: () {
                    var selectedValue = 1;
                    List<DropdownMenuItem<int>> dropdownItems = [];
                    for (int i = 1; i <= boxesQty; i += 50) {
                      int start = i;
                      int end = i + 49 > boxesQty ? boxesQty : i + 49;
                      dropdownItems.add(
                        DropdownMenuItem(
                          value: start,
                          child: Text('$start - $end'),
                        ),
                      );
                    }
                    if (boxesQty > 50) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Material(
                            color: Colors.transparent,
                            child: CustomAlertDialog(
                              title: 'Выберите количество коробок',
                              content: StatefulBuilder(
                                  builder: (context, innerSetState) {
                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    value: selectedValue,
                                    isExpanded: true,
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      padding: REdgeInsets.all(8),
                                    ),
                                    items: dropdownItems,
                                    onChanged: (value) {
                                      innerSetState(() {
                                        selectedValue = value!;
                                      });
                                    },
                                  ),
                                );
                              }),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Отмена'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    int start = selectedValue;
                                    int end = selectedValue + 49 > boxesQty
                                        ? boxesQty
                                        : selectedValue + 49;
                                    String url = barcodeBoxesUrl!
                                        .replaceFirst(
                                            '/1', '/${start.toString()}')
                                        .replaceFirst(
                                            '$boxesQty', end.toString());

                                    launchUrlString(url,
                                        mode: LaunchMode.externalApplication);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Печать'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      launchUrlString(barcodeBoxesUrl!,
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Печать баркода коробок'),
                      Icon(FontAwesomeIcons.box),
                    ],
                  ),
                ),
              SizedBox(height: 3.h),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SalesCommentsPage(id: widget.id),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Комментарии'),
                      Icon(FontAwesomeIcons.comment)
                    ],
                  )),
              SizedBox(height: salesDetails.btnPostpone ? 3.h : 0),
              if (salesDetails.btnPostpone)
                ElevatedButton(
                    onPressed: () {
                      _detailsBloc
                          .add(PostponeEvent(id: widget.id, context: context));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Отложить накладную'),
                        Icon(FontAwesomeIcons.pause)
                      ],
                    )),
              SizedBox(height: salesDetails.editUrl != null ? 3.h : 0),
              if (salesDetails.editUrl != null)
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  InvoiceEditPage(url: salesDetails.editUrl!)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Редактировать накладную'),
                        Icon(FontAwesomeIcons.penToSquare)
                      ],
                    )),
              SizedBox(height: 3.h),
              SizedBox(height: salesDetails.operationPermission ? 3.h : 0),
              if (salesDetails.operationPermission)
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OperationSalesPage(
                                    id: widget.id,
                                    totalPrice: salesDetails.totalPrice,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Операции'),
                        Icon(FontAwesomeIcons.moneyBillTransfer)
                      ],
                    )),
              SizedBox(height: 3.h),
              if (salesDetails.btnBan)
                ElevatedButton(
                    onPressed: () {
                      _detailsBloc.add(MovingRedirectionEvent(
                        id: widget.id,
                        act: 'canceledRequest',
                        context: context,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Отменить накладную'),
                        Icon(FontAwesomeIcons.ban)
                      ],
                    )),
            ],
          ),
        );
      },
    );
  }
}
