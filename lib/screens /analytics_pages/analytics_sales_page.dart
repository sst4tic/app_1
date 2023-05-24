import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yiwucloud/util/analytics_top_sales_model.dart';

import '../../bloc/analytics_directory/analytics_top_sales_bloc/analytics_top_sales_bloc.dart';
import '../../util/styles.dart';

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
                      buildManagers(managersList: state.analytics.managersList),
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

  Widget buildChannels({required List<ChannelsList> channelsList}) {
    return ListView.builder(
        padding: REdgeInsets.all(8),
        itemCount: channelsList.length,
        itemBuilder: (context, index) {
          final channel = channelsList[index];
          var percent = channel.planPercentage / 100;
          if (percent > 1) {
            percent = 1.0;
          }
          return Container(
            padding: REdgeInsets.all(8),
            margin: REdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      channel.name,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    const Spacer(),
                    Container(
                      padding: REdgeInsets.only(left: 0, right: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.green[800],
                            size: 20,
                          ),
                          Text(
                            '${channel.totalSumDifferencePercentage}%',
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Возвраты'.toUpperCase(),
                          style: TextStyles.editStyle,
                        ),
                        Text(
                          '${channel.totalSumReturns.toString()} ₸',
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'продано'.toUpperCase(),
                          style: TextStyles.editStyle,
                        ),
                        Text(
                          '${channel.totalSum} ₸',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${channel.plan.toString()} ₸ план продаж',
                      style: TextStyles.editStyle,
                    ),
                    Text('${channel.planPercentage} %',
                        style: TextStyles.editStyle)
                  ],
                ),
                SizedBox(height: 2.h),
                LinearPercentIndicator(
                  lineHeight: 8.h,
                  percent: percent,
                  widgetIndicator: SizedBox(
                    width: 8.h,
                    height: 8.h,
                  ),
                  padding: const EdgeInsets.all(0),
                  barRadius: const Radius.circular(8),
                  backgroundColor: Colors.grey[300],
                  progressColor: Colors.blue,
                ),
              ],
            ),
          );
        });
  }

  Widget buildManagers({required List<ManagersList> managersList}) {
    return ListView.builder(
        padding: REdgeInsets.all(8),
        itemCount: managersList.length,
        itemBuilder: (context, index) {
          final manager = managersList[index];
          var percent = manager.planPercentage / 100;
          if (percent > 1) {
            percent = 1.0;
          }
          return Container(
            padding: REdgeInsets.all(8),
            margin: REdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Avatar(
                      placeholderColors: const [Color.fromRGBO(232, 69, 69, 1)],
                      shape: AvatarShape.circle(20),
                      name: manager.fullName,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      margin: const EdgeInsets.all(5),
                    ),
                    SizedBox(width: 8.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          manager.fullName,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(manager.channelName,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: REdgeInsets.only(left: 0, right: 6),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.green[800],
                            size: 20,
                          ),
                          Text(
                            '${manager.totalSumDifferencePercentage}%',
                            style: TextStyle(
                                color: Colors.green[800],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Возвраты'.toUpperCase(),
                          style: TextStyles.editStyle,
                        ),
                        Text(
                          '${manager.totalSumReturns} ₸',
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'продано'.toUpperCase(),
                          style: TextStyles.editStyle,
                        ),
                        Text(
                          '${manager.totalSum} ₸',
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${manager.plan} ₸ план продаж',
                      style: TextStyles.editStyle,
                    ),
                    Text('${manager.planPercentage} %',
                        style: TextStyles.editStyle)
                  ],
                ),
                SizedBox(height: 2.h),
                LinearPercentIndicator(
                  lineHeight: 8.h,
                  percent: percent,
                  widgetIndicator: Container(
                    width: 8.h,
                    height: 8.h,
                  ),
                  padding: const EdgeInsets.all(0),
                  barRadius: const Radius.circular(8),
                  backgroundColor: Colors.grey[300],
                  progressColor: Colors.blue,
                ),
              ],
            ),
          );
        });
  }
}
