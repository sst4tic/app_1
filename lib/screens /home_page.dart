import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/screens%20/service_page.dart';
import 'package:yiwucloud/util/function_class.dart';
import 'package:yiwucloud/util/styles.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> _items = <String>['CRM', 'Склад', 'Сотрудники', 'Бухгалтерия', 'Аналитика'];
  static const List<String> subtitles = <String>['Лиды и продажи', 'Склады, магазины, товары', 'Управление сотрудниками', 'Учеты, касса, расходы', 'Продажи, маркетинг, сотрудники'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Все сервисы'),
      ),
      body: GridView.builder(
        padding: REdgeInsets.all(8),
          gridDelegate: GridDelegateClass.gridDelegate,
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
          var limSubtitles = Func().strLimit(subtitles[index], 20);
        return GestureDetector(
          onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => const ServicePage(), fullscreenDialog: true)),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const Icon(Icons.ac_unit, size: 40,),
                SizedBox(height: 10.h),
                Text(_items[index], style: const TextStyle(fontSize: 14)),
                SizedBox(height: 6.h),
                Text(limSubtitles, style: const TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center, maxLines: 1,),
              ],
            )
          ),
        );
      },
      )
    );
  }
}
