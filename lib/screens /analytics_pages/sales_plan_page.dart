import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yiwucloud/models%20/sales_plan_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:yiwucloud/screens%20/analytics_pages/plan_view_page.dart';
import 'package:yiwucloud/util/styles.dart';
import '../../util/constants.dart';

class SalesPlanPage extends StatefulWidget {
  const SalesPlanPage({Key? key}) : super(key: key);

  @override
  State<SalesPlanPage> createState() => _SalesPlanPageState();
}

class _SalesPlanPageState extends State<SalesPlanPage> {
  late final Future<List<SalesPlanListModel>> _salesPlanFuture;

  @override
  void initState() {
    super.initState();
    _salesPlanFuture = getSalesPlan();
  }

  Future<List<SalesPlanListModel>> getSalesPlan() async {
    var url = '${Constants.API_URL_DOMAIN}action=crm_sale_plan';
    final response =
    await http.get(Uri.parse(url), headers: Constants.headers());
    final body = jsonDecode(response.body);
    final data = body['data'];
    return data
        .map<SalesPlanListModel>((json) => SalesPlanListModel.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('План продаж'),
      ),
      body: FutureBuilder<List<SalesPlanListModel>>(
        future: _salesPlanFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final month = snapshot.data![index];
                return Container(
                  decoration: Decorations.containerDecoration,
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlanViewPage(hash: month.hash),
                        ),
                      );
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        month.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: Text(
                      '${month.succeedAmount} / ${month.totalAmount} ₸',
                      style: TextStyles.editStyle.copyWith(fontSize: 13)
                    )
                  ),
                );
              },
            );
          } else if(snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const SizedBox();
        }
      )
    );
  }
}
