import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../screens /service_page.dart';
import '../screens /storage_pages/all_products_page.dart';
import '../util/function_class.dart';
import '../util/styles.dart';

Widget buildServices(services) {
  return GridView.builder(
    padding: REdgeInsets.all(8),
    gridDelegate: GridDelegateClass.gridDelegate,
    itemCount: services.length,
    itemBuilder: (BuildContext context, int index) {
      var service = services[index];
      var limSubtitles = Func().strLimit(service.desc, 20);
      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ServicePage(name: service.name,),
                fullscreenDialog: true)),
        child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.string(service.icon, height: 35, color: Colors.blue),
                SizedBox(height: 10.h),
                Text(service.name, style: const TextStyle(fontSize: 14)),
                SizedBox(height: 6.h),
                Text(
                  limSubtitles,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            )),
      );
    },
  );
}

Widget buildServiceChild(services) {
  return GridView.builder(
    padding: REdgeInsets.all(8),
    gridDelegate: GridDelegateClass.gridDelegate,
    itemCount: services.length,
    itemBuilder: (BuildContext context, int index) {
      var service = services[index];
      var limSubtitles = Func().strLimit(service.desc, 20);
      return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AllProductsPage())),
        child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.string(service.icon, height: 35, color: Colors.blue),
                SizedBox(height: 10.h),
                Text(service.name, style: const TextStyle(fontSize: 14)),
                SizedBox(height: 6.h),
                Text(
                  limSubtitles,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            )),
      );
    },
  );
}