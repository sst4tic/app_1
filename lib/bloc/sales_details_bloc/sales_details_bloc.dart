import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/constants.dart';
import '../../util/sales_details_model.dart';
import 'package:http/http.dart' as http;
part 'sales_details_event.dart';
part 'sales_details_state.dart';

class SalesDetailsBloc extends Bloc<SalesDetailsEvent, SalesDetailsState> {
  SalesDetailsBloc() : super(SalesDetailsInitial()) {
    Future<SalesDetailsModel> loadSalesDetails({required int id}) async {
      var url = '${Constants.API_URL_DOMAIN}action=sale_details&id=$id';
      final response = await http.get(
          Uri.parse(url),
          headers: Constants.headers()
      );
      final body = jsonDecode(response.body);
      final data = body['data'];
      final salesDetails = SalesDetailsModel.fromJson(data);
      return salesDetails;
    }
    Future movingRedirection({required int id, required String act}) async {
      var url = '${Constants
          .API_URL_DOMAIN}action=sale_moving_redirection&id=$id&act=$act';
      final response = await http.get(
          Uri.parse(url),
          headers: Constants.headers()
      );
      final body = jsonDecode(response.body);
      return body;
    }
    on<LoadSalesDetails>((event, emit) async {
      try {
        if (state is! SalesDetailsLoading) {
          emit(SalesDetailsLoading());
          final salesDetails = await loadSalesDetails(id: event.id);
          emit(SalesDetailsLoaded(salesDetails: salesDetails));
        }
      } catch(e) {
        emit(SalesDetailsLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
    on<MovingRedirectionEvent>((event, emit) async {
      final redirection = await movingRedirection(id: event.id, act: event.act);
      final salesDetails = await loadSalesDetails(id: event.id);
      if (redirection['success']) {
        // ignore: use_build_context_synchronously
        showDialog(context: event.context, builder: (context) {
          return AlertDialog(
            title: const Text('Успешно'),
            content: Text(redirection['message']),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Ок'),
              )
            ],
          );
        });
        emit(SalesDetailsLoaded(salesDetails: salesDetails));
      } else {
        // ignore: use_build_context_synchronously
        showDialog(context: event.context, builder: (context) {
          return AlertDialog(
            title: const Text('Произошла ошибка'),
            content: Text(redirection['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ок'),
              )
            ],
          );
        });
      }
    }
    );
  }
}