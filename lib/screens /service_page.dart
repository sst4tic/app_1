import 'package:flutter/material.dart';
import 'package:yiwucloud/screens%20/second_service_page.dart';

import '../util/styles.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  static const List<String> _items = <String>[
    'asd',
    'aaa',
    'bbb',
    'ccc',
    'test'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Service Name'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: GridDelegateClass.gridDelegate,
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondServicePage(),
                  )),
              child: Card(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.ac_unit),
                  Text(_items[index]),
                ],
              )),
            );
          },
        ));
  }
}
