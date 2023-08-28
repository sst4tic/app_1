import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/util/styles.dart';
import '../../util/constants.dart';
import '../../util/logs_model.dart';

class ProductHistory extends StatefulWidget {
  const ProductHistory({Key? key, required this.logs, required this.prodId})
      : super(key: key);
  final List logs;
  final int prodId;

  @override
  State<ProductHistory> createState() => _ProductHistoryState();
}

class _ProductHistoryState extends State<ProductHistory> {
  late final List<DropdownMenuItem> warehouseList;
  final ScrollController _sController = ScrollController();
  int urlPage = 1;
  bool hasMore = true;
  List<Logs> list = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    getLogs(prodId: widget.prodId, warehouseId: 1, page: urlPage);
    warehouseList = widget.logs
        .map((e) => DropdownMenuItem(
              value: e.value,
              child: Text(e.text),
            ))
        .toList();
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        if (hasMore) {
          getLogs(
              prodId: widget.prodId,
              warehouseId: warehouseList[selectedIndex].value,
              page: urlPage);
        }
      }
    });
  }

  Future<List<Logs>> getLogs(
      {required int prodId,
      required int warehouseId,
      required int page}) async {
    var url =
        '${Constants.API_URL_DOMAIN}action=product_logs&product_id=$prodId&warehouse_id=$warehouseId&page=$page';
    final response =
        await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        if (List.from(body['data'].map((e) => Logs.fromJson(e)).toList())
            .isNotEmpty) {
          urlPage++;
        }
        if (List.from(body['data'].map((e) => Logs.fromJson(e)).toList())
            .isEmpty) {
          hasMore = false;
        }
        list.addAll(
            List.from(body['data'].map((e) => Logs.fromJson(e)).toList()));
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('История перемещений'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(58),
              child: Container(
                width: double.infinity,
                margin: REdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      buttonStyleData: ButtonStyleData(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          padding: REdgeInsets.all(8)),
                      hint: const Text('Склад'),
                      value: warehouseList[selectedIndex].value,
                      items: warehouseList,
                      onChanged: (v) {
                        setState(() {
                          list.clear();
                          urlPage = 1;
                          hasMore = true;
                          selectedIndex = warehouseList.indexOf(warehouseList
                              .firstWhere((element) => element.value == v));
                          getLogs(
                              prodId: widget.prodId,
                              warehouseId: v,
                              page: urlPage);
                        });
                      }),
                ),
              ),
            )),
        body: buildLogs());
  }

  Widget buildLogs() {
    return CustomScrollView(
      controller: _sController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return const Divider(height: 1);
            },
            childCount: 1,
          ),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final log = list[index];
              return ListTile(
                title: Text('${log.type} | ${log.recorder}'),
                subtitle: Text(log.createdAt),
                trailing: Text(
                    'Было ${log.qtyOld} \nCтало ${log.qtyNew}'.toUpperCase(),
                    style: TextStyles.editStyle),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.04),
              child: Center(
                  child:
                      hasMore && list.length >= 10
                      ? const CircularProgressIndicator()
                      : const Text('Больше данных нет')))
        ),
      ],
    );
  }
}
