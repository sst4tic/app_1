import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/sales_comments_page.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/sales_details_chronology.dart';
import '../../../bloc/sales_details_bloc/sales_details_bloc.dart';
import '../../../models /build_sales_details.dart';

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
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (state is SalesDetailsLoaded) {
            printUrl = state.salesDetails.printUrl;
            return Scaffold(
              appBar: AppBar(
                title: Text('Накладная № ${widget.invoiceId}'),
                actions: [
                  state.salesDetails.btnSheet
                      ? IconButton(
                          onPressed: () {
                            bottomSheet(
                                btnChronology: state.salesDetails.btnChronology,
                                btnBan: state.salesDetails.btnBan,
                                btnPrint: state.salesDetails.btnPrint,
                                btnPostpone: state.salesDetails.btnPostpone);
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

  bottomSheet(
      {required bool btnChronology,
      required bool btnBan,
      required bool btnPrint,
      required bool btnPostpone}) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: REdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Дополнительные действия',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              if (btnChronology)
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsChronology(id: widget.id),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Хронология'),
                        Icon(FontAwesomeIcons.codeBranch)
                      ],
                    )),
              SizedBox(height: 4.h),
              if (btnPrint)
                ElevatedButton(
                    onPressed: () {
                      launchUrlString(printUrl,
                          mode: LaunchMode.externalApplication);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Печать накладной'),
                        Icon(FontAwesomeIcons.print)
                      ],
                    )),
              SizedBox(height: 4.h),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Комментарии'),
                      Icon(FontAwesomeIcons.comment)
                    ],
                  )),
              SizedBox(height: btnPostpone ? 4.h : 0),
              if (btnPostpone)
                ElevatedButton(
                    onPressed: () {
                      _detailsBloc
                          .add(PostponeEvent(id: widget.id, context: context));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[700],
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Отложить накладную'),
                        Icon(FontAwesomeIcons.pause)
                      ],
                    )),
              SizedBox(height: 4.h),
              if (btnBan)
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
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
