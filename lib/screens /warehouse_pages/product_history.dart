import 'package:flutter/material.dart';
import 'package:yiwucloud/util/styles.dart';
import '../../util/product_details.dart';

class ProductHistory extends StatelessWidget {
  const ProductHistory({Key? key, required this.logs}) : super(key: key);
  final List<Logs> logs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История перемещений'),
      ),
      body: logs.isNotEmpty
          ? ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return ListTile(
                  title: Text('${log.data.message} ${log.id}'),
                  subtitle: Text('${log.createdAt} ${log.name}'),
                  trailing: Text(
                      'Было ${log.data.qtyOld} \nCтало ${log.data.qtyNew}'
                          .toUpperCase(),
                      style: TextStyles.editStyle),
                );
              },
            )
          : const Center(
              child: Text(
              'Нет перемещений',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
    );
  }
}
