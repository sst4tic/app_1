import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yiwucloud/models%20/operations_model.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/arrival_details_page.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/moving_details_page.dart';
import 'package:yiwucloud/screens%20/warehouse_pages/warehouse_sales_pages/warehouse_sales_details.dart';
import 'package:yiwucloud/util/moving_model.dart';
import '../screens /warehouse_pages/product_detail.dart';
import '../util/arrival_model.dart';
import '../util/product.dart';
import '../util/styles.dart';
import '../util/warehouse_sale.dart';

Widget buildArrival(
    {required List<ArrivalModel> arrival,
    required ScrollController controller,
    required BuildContext context,
    required VoidCallback onRefresh,
    required bool hasMore}) {
  return RefreshIndicator(
    onRefresh: () async {
      onRefresh();
    },
    child: CustomScrollView(
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: REdgeInsets.all(8),
            itemCount: arrival.length,
            itemBuilder: (context, index) {
              final arrivalItem = arrival[index];
              return Container(
                padding: REdgeInsets.symmetric(horizontal: 12),
                margin: REdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '# ${arrivalItem.id}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ArrivalDetailsPage(
                                    id: arrivalItem.id.toString(),
                                  );
                                },
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                elevation: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Открыть',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('менеджер'.toUpperCase(), style: TextStyles.editStyle),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 12,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(arrivalItem.managerName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'куда '.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(arrivalItem.warehouseName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                    const Divider(),
                    Center(
                      child: Text(
                        'Создано: ${arrivalItem.createdAt}',
                        style: TextStyles.editStyle,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
              child: arrival.length <= 10 || hasMore == false
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

Widget buildSales(
    {required List<Sales> salesModel,
    required bool btnPermission,
    required int total,
    required ScrollController controller,
    required BuildContext context,
    required VoidCallback onRefresh,
    required bool hasMore}) {
  return RefreshIndicator(
    onRefresh: () async {
      onRefresh();
    },
    child: CustomScrollView(
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: REdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Количество накладных:'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$total',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            padding: REdgeInsets.all(8),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: salesModel.length,
            itemBuilder: (context, index) {
              final sales = salesModel[index];
              return Container(
                padding: REdgeInsets.symmetric(horizontal: 12),
                margin: REdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: sales.statusName == 'Отпущено'
                      ? Border.all(color: Colors.green, width: 1.5)
                      : (sales.statusName == 'Отменено'
                          ? Border.all(color: Colors.red, width: 1.5)
                          : Border.all(color: Colors.transparent)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '# ${sales.invoiceId}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WareHouseSalesDetails(
                                    invoiceId: sales.invoiceId,
                                    id: sales.id,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                elevation: 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.visibility,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  'Открыть',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: sales.typeName == 'Возвратная'
                            ? Colors.blue
                            : sales.typeName == 'Предзаказ'
                                ? Colors.black
                                : Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          sales.typeName!.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: sales.typeName == 'Предзаказ'
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'статус'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: sales.statusName == 'Отпущено'
                            ? Colors.green[200]
                            : (sales.statusName == 'Отменено'
                                ? Colors.red[200]
                                : Theme.of(context).scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(sales.statusName!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'канал'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(sales.saleChannelName ?? 'Канал не указан',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'сотрудник'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 12,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(sales.managerName ?? 'Сотрудник не указан',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'клиент'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(sales.clientName ?? 'Клиент не указан',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    sales.kaspiNum != null
                        ? Text(
                            'заявка kaspi'.toUpperCase(),
                            style: TextStyles.editStyle,
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: sales.kaspiNum != null ? 5.h : 0,
                    ),
                    sales.kaspiNum != null
                        ? Container(
                            padding: REdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(sales.kaspiNum ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: sales.kaspiNum != null ? 5.h : 0,
                    ),
                    Text(
                      'сообщения'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding:
                          REdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Нет сообщений',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Divider(),
                    Text(
                      'сумма'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('${sales.totalPrice ?? 0} ₸',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const Divider(),
                    Center(
                      child: Text(
                        sales.createdAt!,
                        style: TextStyles.editStyle,
                      ),
                    ),
                    const Divider(),
                    Center(
                      child: Text(
                        sales.source ?? '',
                        style: TextStyles.editStyle,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
              child: salesModel.length <= 10 || hasMore == false
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

Widget buildProducts(
    {required List<Product> products,
    required ScrollController controller,
    required bool hasMore}) {
  return CustomScrollView(
    controller: controller,
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return const Divider(height: 0);
          },
          childCount: 1,
        ),
      ),
      SliverToBoxAdapter(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: REdgeInsets.all(8),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final availabilityString = product.availability
                    ?.map((item) => '${item.name} | ${item.location}')
                    .join('\n') ??
                'Нет в наличии';
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetail(id: product.id);
                  }));
                },
                child: Padding(
                  padding: REdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Text(product.categoryName!),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Артикул: ${product.sku}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        availabilityString,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${product.price.toString()} ₸',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 0,
            );
          },
        ),
      ),
      SliverToBoxAdapter(
        child: Center(
            child: products.length <= 5 || hasMore == false
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
  );
}

Widget buildMoving({
  required List<MovingModel> moving,
  required ScrollController controller,
  required BuildContext context,
  required bool hasMore,
}) {
  return CustomScrollView(
    controller: controller,
    slivers: [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return const Divider(height: 0);
          },
          childCount: 1,
        ),
      ),
      SliverToBoxAdapter(
          child: ListView.builder(
        padding: REdgeInsets.only(left: 8, right: 8, bottom: 8),
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: moving.length,
        itemBuilder: (context, index) {
          final movingItem = moving[index];
          return Container(
            padding: REdgeInsets.symmetric(horizontal: 12),
            margin: REdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: movingItem.statusName == 'Выполнено'
                  ? Border.all(color: Colors.green, width: 1.5)
                  : (movingItem.statusName == 'Отменено'
                      ? Border.all(color: Colors.red, width: 1.5)
                      : Border.all(color: Colors.transparent)),
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '# ${movingItem.movingId}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovingDetailsPage(
                                movingId: movingItem.movingId,
                                id: movingItem.id,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'Открыть',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
                const Divider(
                  height: 0,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'статус'.toUpperCase(),
                  style: TextStyles.editStyle,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: REdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: movingItem.statusName == 'Выполнено'
                        ? Colors.green[200]
                        : (movingItem.statusName == 'Отменено'
                            ? Colors.red[200]
                            : Theme.of(context).scaffoldBackgroundColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(movingItem.statusName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Text(
                      'откуда '.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.circleArrowRight,
                      size: 12,
                      color: Colors.grey,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(movingItem.warehouseFromData,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Text(
                      'куда '.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.circleArrowLeft,
                      size: 12,
                      color: Colors.grey,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(movingItem.warehouseToData,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text('создал'.toUpperCase(), style: TextStyles.editStyle),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 12,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(movingItem.senderData,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'сообщения'.toUpperCase(),
                  style: TextStyles.editStyle,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  padding: REdgeInsets.symmetric(vertical: 6, horizontal: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Нет сообщений',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Divider(),
                Center(
                  child: Text(
                    'Создано: ${movingItem.createdAt}',
                    style: TextStyles.editStyle,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          );
        },
      )),
      SliverToBoxAdapter(
        child: Center(
            child: moving.length <= 10 || hasMore == false
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
  );
}

Widget buildOperations(
    {required OperationModel operationModel,
    required ScrollController controller,
    required BuildContext context,
    required VoidCallback onRefresh,
    required Function(int id) onDelete,
    required bool hasMore}) {
  final operationList = operationModel.operations;
  return RefreshIndicator(
    onRefresh: () async {
      onRefresh();
    },
    child: CustomScrollView(
      controller: controller,
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
                      'Сумма поступлений:'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      operationModel.totalSumIncome,
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
                      'Сумма расходов:'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      operationModel.totalSumExpense,
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
                      'Сальдо:'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      operationModel.totalSaldo,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            padding: REdgeInsets.all(8),
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: operationList.length,
            itemBuilder: (context, index) {
              final operations = operationList[index];
              return Container(
                padding: REdgeInsets.symmetric(horizontal: 12),
                margin: REdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.transparent),
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '#${operations.id}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const Spacer(),
                        operationModel.deleteBtn && !operations.isDeleted
                            ? ElevatedButton(
                                onPressed: () => onDelete(operations.id),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red, elevation: 0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    const Text(
                                      'Удалить',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ))
                            : operations.isDeleted
                                ? Container(
                                    padding: REdgeInsets.all(4),
                                    margin: REdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red,
                                    ),
                                    child: const Text(
                                      'Удален',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox(
                                    height: 25.h,
                                  ),
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: operations.typeName == 'Поступление'
                            ? Colors.green[200]
                            : (operations.typeName == 'Расход'
                                ? Colors.red[200]
                                : Theme.of(context).scaffoldBackgroundColor),
                        borderRadius: BorderRadius.circular(8),
                        border: operations.typeName == 'Поступление'
                            ? Border.all(color: Colors.green, width: 1.5)
                            : (operations.typeName == 'Расход'
                                ? Border.all(color: Colors.red, width: 1.5)
                                : Border.all(color: Colors.transparent)),
                      ),
                      child: Center(
                        child: Text(
                          operations.typeName.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'счет'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(operations.billName,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'сотрудник'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(operations.managerName,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'комментарии'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    InkWell(
                      hoverColor: Colors.red,
                      onTap: () {
                        operations.invoiceId != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WareHouseSalesDetails(
                                    invoiceId: operations.invoiceId!,
                                    id: int.parse(operations.invoiceId!),
                                  ),
                                ),
                              )
                            : null;
                      },
                      child: Container(
                        padding:
                            REdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(operations.comments ?? 'Нет сообщений',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const Divider(),
                    Text(
                      'сумма'.toUpperCase(),
                      style: TextStyles.editStyle,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('${operations.totalSum} ₸',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const Divider(),
                    Center(
                      child: Text(
                        operations.createdAt,
                        style: TextStyles.editStyle,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Center(
              child: operationList.length <= 9 || hasMore == false
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
