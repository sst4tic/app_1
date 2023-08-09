import 'package:flutter/material.dart';

import '../../util/styles.dart';

class OperationsPage extends StatefulWidget {
  const OperationsPage({Key? key}) : super(key: key);

  @override
  State<OperationsPage> createState() => _OperationsPageState();
}

class _OperationsPageState extends State<OperationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Мои операции'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Зарплата',
                  style: TextStyles.editStyle.copyWith(fontSize: 13, color: Colors.black)),
              subtitle: const Text('07-08-2023'),
              trailing: Text('+300000 ₸',
                  style: TextStyles.editStyle
                      .copyWith(fontSize: 13, color: Colors.green)),
            ),
            const Divider(height: 0),
            ListTile(
              title: Text('Возврат долга',
                  style: TextStyles.editStyle.copyWith(fontSize: 13, color: Colors.black)),
              subtitle: const Text('03-08-2023'),
              trailing: Text('-50000 ₸',
                  style: TextStyles.editStyle
                      .copyWith(fontSize: 13, color: Colors.red)),
            ),
            const Divider(height: 0),
            ListTile(
              title: Text('Долг',
                  style: TextStyles.editStyle.copyWith(fontSize: 13, color: Colors.black)),
              subtitle: const Text('01-08-2023'),
              trailing: Text('+300000 ₸',
                  style: TextStyles.editStyle
                      .copyWith(fontSize: 13, color: Colors.green)),
            ),
          ],
        ));
  }
}
