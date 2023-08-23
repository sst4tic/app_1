import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/main.dart';
import 'package:yiwucloud/models%20/custom_dialogs_model.dart';
import 'package:yiwucloud/util/function_class.dart';
import '../../screens /arrival_details_page.dart';
import '../../util/arrival_existence_model.dart';
import 'create_arrival_repo.dart';

part 'create_arrival_event.dart';
part 'create_arrival_state.dart';

class CreateArrivalBloc extends Bloc<CreateArrivalEvent, CreateArrivalState> {
  CreateArrivalBloc() : super(CreateArrivalInitial()) {
    final createArrivalRepo = CreateArrivalRepo();
    on<CheckExistenceEvent>((event, emit) async {
      try {
        final arrival =
            await createArrivalRepo.checkArrivalExistence(sku: event.sku);
        final warehouses = await Func().loadWarehousesList(0);
        List<DropdownMenuItem<String>> mappedWarehouses = warehouses
            .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
                value: e['id'].toString(), child: Text(e['name_lang']!)))
            .toList();
        if (arrival.exists) {
          emit(ArrivalExist(arrival: arrival, warehouses: mappedWarehouses));
        } else {
          emit(ArrivalNotExist(sku: event.sku, warehouses: mappedWarehouses));
        }
      } catch (e) {
        emit(CreateArrivalError(e: e));
      }
    });
    on<AddExistArrivalEvent>((event, emit) async {
      final resp = await createArrivalRepo.addExistArrival(
          sku: event.sku,
          warehouseId: event.warehouseId,
          quantity: event.quantity,
          id: event.id);
      showDialog(
          context: navKey.currentContext!,
          builder: (context) {
            return CustomAlertDialog(
              title: resp['success'] ? 'Успешно!' : 'Произошла ошибка!',
              content: Text(resp['message']),
              actions: [
                CustomDialogAction(
                  text: 'Ок',
                  onPressed: () {
                    Navigator.of(context).pop();
                    resp['success'] ? navKey.currentState!.pop() : null;
                    resp['arrival_id'] != null ? navKey.currentState!.push(MaterialPageRoute(builder:
                    (context) => ArrivalDetailsPage(id: resp['arrival_id'].toString(),))) : null;
                  },
                )
              ],
            );
          });
    });

    on<AddNonExistArrivalEvent>((event, emit) async {
      final resp = await createArrivalRepo.addNonExistArrival(
          sku: event.sku,
          warehouseId: event.warehouseId,
          quantity: event.quantity,
          name: event.name,
          price: event.price);
      showDialog(
          context: navKey.currentContext!,
          builder: (context) {
            return CustomAlertDialog(
              title: resp['success'] ? 'Успешно!' : 'Произошла ошибка!',
              content: Text(resp['message']),
              actions: [
                CustomDialogAction(
                  text: 'Ок',
                  onPressed: () {
                    Navigator.of(context).pop();
                    resp['success'] ? navKey.currentState!.pop() : null;
                    resp['arrival_id'] != null ? navKey.currentState!.push(MaterialPageRoute(builder:
                        (context) => ArrivalDetailsPage(id: resp['arrival_id'].toString(),))) : null;
                  },
                )
              ],
            );
          });
    });
  }
}
