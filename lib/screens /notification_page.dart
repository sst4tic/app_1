import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
import '../util/function_class.dart';
import '../util/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationClass>> notificationFuture;

  @override
  void initState() {
    super.initState();
    notificationFuture = Func().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Уведомления',
        ),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).disabledColor,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onRefresh: () async {
          setState(() {
            notificationFuture = Func().getNotifications();
          });
        },
        child: FutureBuilder(
            future: notificationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Нет уведомлений',
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                }
                final not = snapshot.data!;
                return buildNotifications(not);
              } else {
                // show stack trace
                return const Text("No widget to build");
              }
            }),
      ),
    );
  }

  Widget buildNotifications(List<NotificationClass> notification) =>
      ListView.builder(
          padding: REdgeInsets.all(8.0),
          itemCount: notification.length,
          itemBuilder: (context, index) {
            final notItem = notification[index];
            return Container(
              margin:  REdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,
              ),
              child: ListTile(
                onTap: () {
                  if(notItem.invoiceData != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WareHouseSalesDetails(id: notItem.invoiceData!.id, invoiceId: notItem.invoiceData!.invoiceId,

                            )));
                  }
                },
                contentPadding:
                REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                title: Row(
                    children: [
                      notItem.unread
                          ? const Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 10,
                            )
                          : const SizedBox(),
                      SizedBox(width: notItem.unread ? 5 : 0),
                      Flexible(
                        child: Text(
                          notItem.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ]),
                trailing: Text(notItem.date,
                    style: Theme.of(context).textTheme.bodySmall),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ExpandableText(
                    notItem.body,
                    expandOnTextTap: true,
                    expandText: '',
                    collapseText: '',
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    collapseOnTextTap: true,
                  ),
                ),
              ),
            );
          });
}
