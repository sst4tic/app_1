import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yiwucloud/models%20/accounting_bills_model.dart';
import 'package:yiwucloud/util/styles.dart';

import '../../bloc/accounting_bills_bloc/accounting_bills_bloc.dart';

class AccountingBillsPage extends StatefulWidget {
  const AccountingBillsPage({Key? key}) : super(key: key);

  @override
  State<AccountingBillsPage> createState() => _AccountingBillsPageState();
}

class _AccountingBillsPageState extends State<AccountingBillsPage> {
  final ScrollController _sController = ScrollController();
  final _billsBloc = AccountingBillsBloc();

  @override
  void initState() {
    super.initState();
    _billsBloc.add(LoadAccountingBills());
    _sController.addListener(() {
      if (_sController.position.pixels ==
          _sController.position.maxScrollExtent) {
        _billsBloc.add(LoadMore());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AccountingBillsBloc(),
        child: BlocBuilder<AccountingBillsBloc, AccountingBillsState>(
          bloc: _billsBloc,
          builder: (context, state) {
            if (state is AccountingBillsLoading) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            } else if (state is AccountingBillsLoaded) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Счета'),
                    actions: [
                     state.bills.btnAdd ? IconButton(
                        onPressed: () {
                          _billsBloc.add(CreateAccountingBills());
                        },
                        icon: const Icon(Icons.add),
                      ) : const SizedBox(),
                    ],
                  ),
                  body: buildBills(state.bills, state.hasMore));
            } else if (state is AccountingBillsError) {
              return Text(state.e.toString());
            } else {
              return const SizedBox();
            }
          },
        ),
      );
  }
Widget buildBills(BillsModel bills, bool hasMore) {
    return RefreshIndicator(
      onRefresh: () async {
        _billsBloc.add(LoadAccountingBills());
      },
      child: CustomScrollView(
        controller: _sController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: REdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Количество:'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${bills.totalCount}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
                Container(
                  color: Colors.white,
                  padding: REdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Общая сумма:'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${bills.totalSum} ₸',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 0),
              ],
            ),
          ),
          SliverToBoxAdapter(
           child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bills.bills.length,
              itemBuilder: (context, index) {
                final item = bills.bills[index];
                return ListTile(
                  onTap: () {
                    bills.btnEdit ? _billsBloc.add(BillsEditEvent(id: item.id, name: item.name)) : null;
                  },
                  leading: Text(item.id.toString(), style: TextStyles.editStyle.copyWith(fontSize: 20),),
                  title: Text(item.name),
                  subtitle: Text(item.type),
                  trailing:
                  Text('Баланс: ${item.sum} ₸', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),),
                );
              },
                separatorBuilder: (context, index) {
               return const Divider(height: 0);
             }
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
                child: bills.bills.length <= 9 || hasMore == false
                    ? const Text('Больше нет данных')
                    : const CircularProgressIndicator()),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return SizedBox(
                  height: 20.h,
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
}
}
