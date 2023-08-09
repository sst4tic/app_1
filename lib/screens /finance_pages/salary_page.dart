import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/styles.dart';

class SalaryPage extends StatefulWidget {
  const SalaryPage({Key? key}) : super(key: key);

  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Зарплата'),
     ),
      body: Padding(
        padding: REdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Моя зарплата', style: TextStyles.editStyle.copyWith(fontSize: 13)),
            SizedBox(height: 5.h),
            Container(
              decoration: Decorations.containerDecoration,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Зарплата', style: TextStyles.editStyle.copyWith(fontSize: 13)),
                    trailing: Text('0.00 ₸', style: TextStyles.editStyle.copyWith(fontSize: 13)),
                  ),
                  ListTile(
                    title: Text('Аванс', style: TextStyles.editStyle.copyWith(fontSize: 13)),
                    trailing: Text('0.00 ₸', style: TextStyles.editStyle.copyWith(fontSize: 13)),
                  ),
                  ListTile(
                    title: Text('Итого', style: TextStyles.editStyle.copyWith(fontSize: 13)),
                    trailing: Text('0.00 ₸', style: TextStyles.editStyle.copyWith(fontSize: 13)),
                  ),
                ],
              )
            )
          ],
        ),
      )
   );
  }
}
