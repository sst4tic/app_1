import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../bloc/analytics_directory/analytics_top_sales_bloc/analytics_top_sales_bloc.dart';
import '../../models /build_analytics_models.dart';

class AnalyticsSalesPage extends StatefulWidget {
  const AnalyticsSalesPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsSalesPage> createState() => _AnalyticsSalesPageState();
}

class _AnalyticsSalesPageState extends State<AnalyticsSalesPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController _dateController = TextEditingController();
  final _analyticsSalesBloc = AnalyticsTopSalesBloc();

  final String _date =
      '${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 30)))}/${DateFormat('yyyy-MM-dd').format(DateTime.now())}';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _dateController.text = 'За последний месяц';
    _analyticsSalesBloc.add(LoadAnalyticsTopSales(date: _date));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      saveText: 'Сохранить',
      cancelText: 'Отмена',
      helpText: 'Выберите дату',
      fieldEndLabelText: 'Конец',
      fieldStartLabelText: 'Начало',
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final pickedDate =
          '${picked.start.toString().substring(0, 10)} - ${picked.end.toString().substring(0, 10)}';
      final AmanDate =
          '${picked.start.toString().substring(0, 10)}/${picked.end.toString().substring(0, 10)}';
      _dateController.text = pickedDate;
      _analyticsSalesBloc.add(LoadAnalyticsTopSales(date: AmanDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Аналитика: Топ продаж'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () async {
                      // show cupertino date picker
                      await _selectDate(context);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Выберите дату',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.blue,
                  tabs: const [
                    Tab(text: 'Каналы'),
                    Tab(text: 'Менеджеры'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => AnalyticsTopSalesBloc(),
          child: BlocBuilder<AnalyticsTopSalesBloc, AnalyticsTopSalesState>(
            bloc: _analyticsSalesBloc,
            builder: (context, state) {
              if (state is AnalyticsTopSalesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AnalyticsTopSalesLoaded) {
                return DefaultTabController(
                  length: 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildChannels(channelsList: state.analytics.channelsList),
                      state.analytics.managersList.isNotEmpty ? buildManagers(managersList: state.analytics.managersList) : const Center(child: Text('Нет данных')),
                    ],
                  ),
                );
              } else if (state is AnalyticsTopSalesLoadingFailure) {
                return Center(child: Text(state.exception.toString()));
              }
              return const SizedBox();
            },
          ),
        ));
  }
}