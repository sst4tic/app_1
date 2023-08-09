import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/screens%20/finance_pages/salary_page.dart';

import '../../util/styles.dart';
import 'operations_page.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({Key? key}) : super(key: key);

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Финансы'),
      ),
      body: Padding(
        padding: REdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SalaryPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )),
                padding: REdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.coins,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Зарплата', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                padding: REdgeInsets.all(10),
                decoration:
                BoxDecoration(color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.dollarSign,
                        // FontAwesomeIcons.handHoldingUsd,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Долги', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OperationsPage())
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                padding: REdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.rightLeft,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Text('Операции', style: TextStyles.bodyStyle),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
