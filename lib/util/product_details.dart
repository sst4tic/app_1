class ProductDetails {
  ProductDetails({
    required this.id,
    required this.name,
    required final String createdAt,
    required this.sku,
    this.description,
    this.totalCount,
    required this.price,
    this.logs,
  });

  late final int id;
  late final String name;
  late final String createdAt;
  late final sku;
  late final int price;
  late final String? description;
  late final int? totalCount;
  List<Logs>? logs;

  ProductDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    sku = json['sku'];
    price = json['price_retail'];
    description = json['description'];
    totalCount = json['warehouse_total_count'];
    logs = json['logs'] != null ? List.from(json['logs']).map((e) => Logs.fromJson(e)).toList() : [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['sku'] = sku;
    data['price_retail'] = price;
    data['description'] = description;
    data['warehouse_total_count'] = totalCount;
    data['logs'] = logs?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Logs {
  Logs({
    required this.id,
    required this.productId,
    required this.name,
    required this.data,
    required this.createdAt,
  });

  late final int id;
  late final int productId;
  late final String name;
  late final Data data;
  late final String createdAt;

  Logs.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productId = json['product_id'];
    name = json['name'];
    data = Data.fromJson(json['data']);
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_id'] = productId;
    _data['name'] = name;
    _data['data'] = data.toJson();
    _data['created_at'] = createdAt;
    return _data;
  }
}

class Data {
  Data({
    required this.qty,
    required this.message,
    required this.qtyNew,
    required this.qtyOld,
    required this.typeId,
    this.invoiceId,
    required this.recorderId,
    required this.warehouseId,
  });

  late final qty;
  late final String message;
  late final qtyNew;
  late final int qtyOld;
  late final int typeId;
  late final int? invoiceId;
  late final int recorderId;
  late final String warehouseId;

  Data.fromJson(Map<String, dynamic> json){
    qty = json['qty'];
    message = json['message'];
    qtyNew = json['qty_new'];
    qtyOld = json['qty_old'];
    typeId = json['type_id'];
    invoiceId = null;
    recorderId = json['recorder_id'];
    warehouseId = json['warehouse_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['qty'] = qty;
    data['message'] = message;
    data['qty_new'] = qtyNew;
    data['qty_old'] = qtyOld;
    data['type_id'] = typeId;
    data['invoice_id'] = invoiceId;
    data['recorder_id'] = recorderId;
    data['warehouse_id'] = warehouseId;
    return data;
  }
}

class Warehouses {
  Warehouses({
    required this.count,
    required this.name,
    required this.updatedAt,

  });

  late final int count;
  late final String name;
  late final String updatedAt;


  Warehouses.fromJson(Map<String, dynamic> json){
    count = json['count'];
    name = json['warehouse_name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = count;
    data['warehouse_name'] = name;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProductDetailsWithWarehouses {
  final ProductDetails data;
  final List<Warehouses> warehouses;

  ProductDetailsWithWarehouses({required this.data, required this.warehouses});
}