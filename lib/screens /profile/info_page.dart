import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../util/styles.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.version}) : super(key: key);
  final String version;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: ListView(
        children: [
          Container(
            decoration: Decorations.containerDecoration
                .copyWith(borderRadius: BorderRadius.circular(0)),
            width: double.infinity,
            child: Column(
              children: [
                Image.asset(
                  'assets/img/icon.png',
                  width: 120.w,
                  height: 120.h,
                ),
                const Text(
                  'YiwuCloud',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Версия ${widget.version}',
                  style: TextStyles.editStyle.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(height: 5.h),
          ListTile(
            title: Text(
              'Политика конфиденциальности',
              style: TextStyles.editStyle.copyWith(fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              launchUrlString('https://yiwumart.org/privacy-policy',
                  mode: LaunchMode.externalApplication);
            },
          ),
        ],
      ),
    );
  }
}
