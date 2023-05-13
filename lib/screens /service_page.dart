import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/service_bloc/service_bloc.dart';
import '../models /build_services.dart';
import 'barcode_scanner_page.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
final _serviceBloc = ServiceBloc();

@override
  void initState() {
    super.initState();
    _serviceBloc.add(LoadServices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BarcodeScannerPage()));
              },
              icon: const Icon(Icons.qr_code_scanner_sharp),
            ),
          ],
        ),
        body: BlocProvider<ServiceBloc>(
          create: (context) => ServiceBloc(),
          child: BlocBuilder<ServiceBloc, ServiceState>(
            bloc: _serviceBloc,
            builder: (context, state) {
              if(state is ServiceLoading){
                return const Center(child: CircularProgressIndicator());
              } else if(state is ServiceLoaded){
                return buildServiceChild(state.services);
              } else if(state is ServiceLoadingFailure){
                return Text(state.exception.toString());
              } else {
                return const Center(
                  child: Text('ELSE'),
                );
              }
            },
          ),
        ));
  }
}
