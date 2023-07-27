import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/util/moving_model.dart';

import 'moving_repo.dart';

part 'warehouse_moving_event.dart';

part 'warehouse_moving_state.dart';

class WarehouseMovingBloc
    extends Bloc<WarehouseMovingEvent, WarehouseMovingState> {
  WarehouseMovingBloc() : super(WarehouseMovingInitial()) {
    final movingRepo = MovingRepo();
    int page = 1;
    String query = '';
    List<MovingModel> warehouseMoving = [];
    on<LoadMoving>((event, emit) async {
      try {
        if (state is! WarehouseMovingLoading) {
          emit(WarehouseMovingLoading());
          warehouseMoving = await movingRepo.getMoving(page: page, query: event.query);
          query = event.query ?? '';
          emit(WarehouseMovingLoaded(
              warehouseMoving: warehouseMoving, page: 1, hasMore: true));
        }
      } catch (e) {
        emit(WarehouseMovingLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<LoadMore>((event, emit) async {
      try {
        if (state is WarehouseMovingLoaded && state.hasMore) {
          final warehouseMoving =
              (state as WarehouseMovingLoaded).warehouseMoving;
          final newWarehouseMoving =
              await movingRepo.getMoving(page: state.page + 1, query: query);
          warehouseMoving.addAll(newWarehouseMoving);
          emit(WarehouseMovingLoaded(
              warehouseMoving: warehouseMoving,
              page: state.page + 1,
              hasMore: newWarehouseMoving.isNotEmpty));
        }
      } catch (e) {
        emit(WarehouseMovingLoadingFailure(exception: e));
      }
    });
  }
}
