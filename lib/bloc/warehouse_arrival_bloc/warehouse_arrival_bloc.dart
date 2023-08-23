import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../util/arrival_model.dart';
import 'arrival_repo.dart';
part 'warehouse_arrival_event.dart';
part 'warehouse_arrival_state.dart';

class WarehouseArrivalBloc extends Bloc<WarehouseArrivalEvent, WarehouseArrivalState> {
  WarehouseArrivalBloc() : super(WarehouseArrivalInitial()) {
    final arrivalRepo = ArrivalRepo();
    int page = 1;
    String filters = '';
    on<LoadArrival>((event, emit) async {
      try {
        if (state is! WarehouseArrivalLoading) {
          emit(WarehouseArrivalLoading());
          filters = event.filters ?? '';
          final warehouseArrival = await arrivalRepo.getArrival(page: page, filters: filters);
          emit(WarehouseArrivalLoaded(
              warehouseArrival: warehouseArrival, page: 1, hasMore: true));
        }
      } catch(e) {
        emit(WarehouseArrivalLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<LoadMore>((event, emit) async {
      try {
        if(state is WarehouseArrivalLoaded && state.hasMore) {
          final warehouseArrival = (state as WarehouseArrivalLoaded).warehouseArrival;
          final newWarehouseArrival = await arrivalRepo.getArrival(page: state.page + 1, filters: filters);
          warehouseArrival.addAll(newWarehouseArrival);
          emit(WarehouseArrivalLoaded(
              warehouseArrival: warehouseArrival,
              page: state.page + 1,
              hasMore: newWarehouseArrival.isNotEmpty));
        }
      } catch(e) {
        emit(WarehouseArrivalLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
