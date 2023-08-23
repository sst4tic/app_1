import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:yiwucloud/bloc/plan_view_bloc/plan_view_bloc.dart';
import '../../models /plan_view_model.dart';
import '../../util/styles.dart';

class PlanViewPage extends StatefulWidget {
  const PlanViewPage({Key? key, required this.hash}) : super(key: key);
  final String hash;

  @override
  State<PlanViewPage> createState() => _PlanViewPageState();
}

class _PlanViewPageState extends State<PlanViewPage> {
  final PlanViewBloc _planViewBloc = PlanViewBloc();

  @override
  void initState() {
    super.initState();
    _planViewBloc.add(LoadPlanView(hash: widget.hash));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Просмотр плана'),
      ),
      body: BlocProvider<PlanViewBloc>(
        create: (context) => PlanViewBloc(),
        child: BlocBuilder<PlanViewBloc, PlanViewState>(
          bloc: _planViewBloc,
          builder: (context, state) {
            if (state is PlanViewLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PlanViewLoaded) {
              return buildPlanView(state.planView);
            } else if (state is PlanViewLoadingFailure) {
              return Center(
                child: Text(state.exception.toString()),
              );
            }
            return const SizedBox();
          },
        ),
      )
    );
  }
  Widget buildPlanView(List<PlanViewModel> plan) {
    return ListView.builder(
      padding: REdgeInsets.all(8),
      itemCount: plan.length,
      itemBuilder: (context, index) {
        final planView = plan[index];
        final totalPercent = planView.total.percent != 0 ? planView.total.percent / 100 : 0.0;
        return Container(
          padding: REdgeInsets.all(8),
          decoration: Decorations.containerDecoration,
          margin: REdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                planView.name,
                style: TextStyles.editStyle.copyWith(fontSize: 15, color: Colors.black),
              ),
              const Divider(),
              planView.managers.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: planView.managers.length,
                itemBuilder: (context, index) {
                  final manager = planView.managers[index];
                  var percent = manager.percent != 0 ? manager.percent / 100 : 0.0;
                  var vertlinePercent = manager.vertLine != 0 ? manager.vertLine / 100 : 0.0;
                  final percentSize = MediaQuery.of(context).size.width * 0.905;
                  return Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                manager.name,
                                style: TextStyles.editStyle.copyWith(fontSize: 13),
                              ),
                              const Spacer(),
                              Text(
                                '${manager.planAmount} ₸',
                                style: TextStyles.editStyle.copyWith(fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          LinearPercentIndicator(
                            lineHeight: 15.h,
                            percent: percent > 1 ? 1.0 : percent.toDouble(),
                            padding: const EdgeInsets.all(0),
                            barRadius: const Radius.circular(8),
                            backgroundColor: Colors.blue[50],
                            progressColor: percent >= vertlinePercent ? Colors.green : Colors.red,
                            center: Text(
                              '${manager.salesTotal} ₸',
                              style: TextStyles.editStyle.copyWith(fontSize: 12, color: Colors.black),
                            ),
                            animation: true,
                          ),
                          if (index != planView.managers.length - 1) const Divider(),
                        ],
                      ),
                      Positioned(
                        left: (percentSize * vertlinePercent).clamp(0.0, MediaQuery.of(context).size.height),
                        top: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: 1.h,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Divider(),
              Row(
                children: [
                  Text(
                    'Итого:',
                    style: TextStyles.editStyle.copyWith(fontSize: 13, color: Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    '${planView.total.totalAmount} ₸',
                    style: TextStyles.editStyle.copyWith(fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              LinearPercentIndicator(
                lineHeight: 15.h,
                percent: totalPercent > 1 ? 1.0 : totalPercent.toDouble(),
                padding: const EdgeInsets.all(0),
                barRadius: const Radius.circular(8),
                backgroundColor: Colors.blue[50],
                progressColor: Colors.blue[400],
                center: Text(
                  '${planView.total.salesTotal} ₸',
                  style: TextStyles.editStyle.copyWith(fontSize: 12, color: Colors.black),
                ),
                animation: true,
              ),
            ],
          ),
        );
      }
    );
  }
}
