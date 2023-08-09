import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../util/styles.dart';

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
      appBar: AppBar(title: const Text('YiwuCloud')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Версия приложения ${widget.version}',
                style: TextStyles.editStyle.copyWith(fontSize: 15)),
          ),
          SizedBox(height: 5.h),
          ElevatedButton(
            onPressed: () {
              launchUrlString('https://yiwumart.org/privacy-policy',
                  mode: LaunchMode.externalApplication);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 35.h),
            ),
            child: const Text('Политика конфиденциальности'),
          ),
        ],
      ),
    );
  }
}
