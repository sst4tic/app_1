import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/models%20/moving_details_widget.dart';

import '../../bloc/moving_details_bloc/moving_details_bloc.dart';

class MovingDetailsPage extends StatefulWidget {
  const MovingDetailsPage({Key? key, required this.id, required this.movingId}) : super(key: key);
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
              return MovingDetailsWidget(salesDetails: state.movingDetails, id: widget.id, invoiceId: widget.movingId, detailsBloc: _movingDetailsBloc);
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
      )
    );
  }


}
