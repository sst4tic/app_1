import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/models%20/moving_details_widget.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/sales_details_chronology.dart';

import '../../bloc/moving_details_bloc/moving_details_bloc.dart';
import '../../util/styles.dart';

class MovingDetailsPage extends StatefulWidget {
  const MovingDetailsPage({Key? key, required this.id, required this.movingId})
      : super(key: key);
  final int id;
  final String movingId;

  @override
  State<MovingDetailsPage> createState() => _MovingDetailsPageState();
}

class _MovingDetailsPageState extends State<MovingDetailsPage> {
  final _movingDetailsBloc = MovingDetailsBloc();

  @override
  void initState() {
    super.initState();
    _movingDetailsBloc.add(LoadMovingDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Перемещение №${widget.movingId}'),
          actions: [
            IconButton(
              onPressed: () {
                bottomSheet();
              },
              icon: const Icon(Icons.more_horiz),
            )
          ],
        ),
        body: BlocProvider<MovingDetailsBloc>(
          create: (context) => MovingDetailsBloc(),
          child: BlocBuilder<MovingDetailsBloc, MovingDetailsState>(
            bloc: _movingDetailsBloc,
            builder: (context, state) {
              if (state is MovingDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MovingDetailsLoaded) {
                return MovingDetailsWidget(
                    salesDetails: state.movingDetails,
                    id: widget.id,
                    invoiceId: widget.movingId,
                    detailsBloc: _movingDetailsBloc);
              } else if (state is MovingDetailsLoadingFailure) {
                return Center(
                  child: Text(state.exception.toString()),
                );
              } else {
                return const Center(
                  child: Text('Unknown error'),
                );
              }
            },
          ),
        ));
  }

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return Container(
            padding: REdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            height: 200,
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
                SizedBox(
                  height: 8.h,
                ),
                ListTile(
                  trailing: const Icon(FontAwesomeIcons.codeBranch),
                  title: Text('Хронология', style: TextStyles.editStyle.copyWith(fontSize: 14),),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsChronology(id: widget.id, isSales: false))
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
