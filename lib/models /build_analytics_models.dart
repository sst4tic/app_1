import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../util/analytics_top_sales_model.dart';
import '../util/styles.dart';

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
                  // Container(
                  //   padding: REdgeInsets.only(left: 0, right: 6),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green[200],
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.arrow_drop_up,
                  //         color: Colors.green[800],
                  //         size: 20,
                  //       ),
                  //       Text(
                  //         '${channel.totalSumDifferencePercentage}%',
                  //         style: TextStyle(
                  //             color: Colors.green[800],
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Возвраты'.toUpperCase(),
                        style: TextStyles.editStyle,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${channel.totalSumReturns.toString()} ₸',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'продано'.toUpperCase(),
                        style: TextStyles.editStyle,
                      ),
                      SizedBox(height: 4.h),
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
                  Text('${channel.planPercentage.round()} %',
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
                backgroundColor: Colors.blue[50],
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
                  // Container(
                  //   padding: REdgeInsets.only(left: 0, right: 6),
                  //   decoration: BoxDecoration(
                  //     color: Colors.green[200],
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(
                  //         Icons.arrow_drop_up,
                  //         color: Colors.green[800],
                  //         size: 20,
                  //       ),
                  //       Text(
                  //         '${manager.totalSumDifferencePercentage}%',
                  //         style: TextStyle(
                  //             color: Colors.green[800],
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Возвраты'.toUpperCase(),
                        style: TextStyles.editStyle,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${manager.totalSumReturns} ₸',
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'продано'.toUpperCase(),
                        style: TextStyles.editStyle,
                      ),
                      SizedBox(height: 4.h),
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
                padding: const EdgeInsets.all(0),
                barRadius: const Radius.circular(8),
                backgroundColor: Colors.blue[50],
                progressColor: Colors.blue,
              ),
            ],
          ),
        );
      });
}
