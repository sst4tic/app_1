import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/sales_details_chronology.dart';
import '../../../bloc/sales_details_bloc/sales_details_bloc.dart';
import '../../../models /build_sales_details.dart';
import '../../../util/styles.dart';

class WareHouseSalesDetails extends StatefulWidget {
  const WareHouseSalesDetails(
      {Key? key, required this.id, required this.invoiceId})
      : super(key: key);
  final int id;
  final String invoiceId;

  @override
  State<WareHouseSalesDetails> createState() => _WareHouseSalesDetailsState();
}

class _WareHouseSalesDetailsState extends State<WareHouseSalesDetails> {
  final _detailsBloc = SalesDetailsBloc();
  String printUrl = '';

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
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              } else if (state is SalesDetailsLoaded) {
                printUrl = state.salesDetails.printUrl;
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Накладная № ${widget.invoiceId}'),
                    actions: [
                      state.salesDetails.btnSheet ?  IconButton(onPressed: () {
                        bottomSheet(btnChronology: state.salesDetails.btnChronology, btnBan: state.salesDetails.btnBan, btnPrint: state.salesDetails.btnPrint);
                }, icon: const Icon(Icons.more_horiz),) : const SizedBox(),
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
                return
                  const Scaffold(body: Center(child: Text('Ошибка сервера')));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
  }
  bottomSheet({required bool btnChronology, required bool btnBan, required bool btnPrint}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 0.4.sh,
            child: Padding(
              padding: REdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Дополнительные действия',
                      style: TextStyles.loginTitle),
                  SizedBox(height: 10.h),
                  btnChronology ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsChronology(
                                    id: widget.id,
                                  )));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 35.h),
                      backgroundColor: Colors.blue[400],
                    ),
                    child: const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Хронология'),
                        Icon(FontAwesomeIcons.codeBranch),
                      ],
                    ),
                  ) : const SizedBox(),
                  SizedBox(height: 10.h),
                 btnPrint ? ElevatedButton(
                    onPressed: () {
                      launchUrlString(printUrl);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 35.h),
                      backgroundColor: Colors.blue[400],
                    ),
                    child: const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Печать'),
                        Icon(FontAwesomeIcons.print),
                      ],
                    ),
                  ) : const SizedBox(),
                  SizedBox(height: 10.h),
                btnBan ? ElevatedButton(
                    onPressed: () {
                      _detailsBloc.add(MovingRedirectionEvent(
                          id: widget.id,
                          act: 'canceledRequest',
                          context: context));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 35.h),
                      backgroundColor: Colors.red,
                    ),
                    child: const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Отмена заявки'),
                        Icon(FontAwesomeIcons.ban),
                      ],
                    ),
                  ) : const SizedBox(),
                ],
              ),
            ),
          );
        });
  }
}
