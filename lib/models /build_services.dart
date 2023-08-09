import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yiwucloud/models%20/haptic_model.dart';
import 'package:yiwucloud/screens%20/analytics_pages/analytics_sales_page.dart';
import 'package:yiwucloud/screens%20/sales_plan_page.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/products_arrival.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/products_moving.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_assembling.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_taking.dart';
import 'package:yiwucloud/util/service.dart';
import '../screens /service_page.dart';
import '../screens /warehouse_pages/all_products_page.dart';
import '../util/function_class.dart';
import '../util/styles.dart';

Widget buildServices(List<Services> services) {
  return GridView.builder(
    padding: REdgeInsets.all(8),
    gridDelegate: GridDelegateClass.gridDelegate,
    itemCount: services.length,
    itemBuilder: (BuildContext context, int index) {
      var service = services[index];
      var limSubtitles = Func().strLimit(service.desc!, 20);
      return SizeTapAnimation(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ServicePage(
                      name: service.name,
                      id: service.id!,
                    ),
                fullscreenDialog: true)),
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.string(service.icon!, height: 35, color: Colors.blue),
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

Widget buildServiceChild(List<Services> services) {
  return GridView.builder(
    padding: REdgeInsets.all(8),
    gridDelegate: GridDelegateClass.gridDelegate,
    itemCount: services.length,
    itemBuilder: (BuildContext context, int index) {
      var service = services[index];
      var limSubtitles = Func().strLimit(service.desc!, 20);
      return SizeTapAnimation(
        onTap: () {
          if (service.id == 19) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllProductsPage()));
          } else if (service.id == 21) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WarehouseSales()));
          } else if (service.id == 22) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProductsMoving()));
          } else if (service.id == 20) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ProductsArrival();
            }));
          } else if (service.id == 40) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const WarehouseTaking();
            }));
          } else if (service.id == 39) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const WarehouseAssembly();
            }));
          } else if (service.id == 33) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const AnalyticsSalesPage();
            }));
          } else if (service.id == 13) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SalesPlanPage();
            }));
          }
        },
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.string(service.icon!, height: 35, color: Colors.blue),
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
