import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiwucloud/bloc/operation_creating_bloc/operation_creating_repo.dart';
import '../bloc/accounting_bills_bloc/accounting_bills_repo.dart';
import '../bloc/home_page_bloc/home_page_bloc.dart';
import '../models /build_services.dart';
import '../util/function_class.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homePageBloc = HomePageBloc();

  @override
  void initState() {
    super.initState();
    _homePageBloc.add(LoadServices());
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await Func().getProductsFilters();
    await Func().loadWarehousesList();
    await OperationCreatingRepo().getBillsList();
    await AccountingBillsRepo().getBillsTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Все сервисы'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
        ),
        body: BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
          child: BlocBuilder<HomePageBloc, HomePageState>(
            bloc: _homePageBloc,
            builder: (context, state) {
              if (state is HomePageLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomePageLoaded) {
                return buildServices(state.services);
              } else if (state is HomePageLoadingFailure) {
                return Text(state.exception.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        ));
  }
}
