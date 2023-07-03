class WarehouseSalesModel {
  WarehouseSalesModel({
    required this.btnPermission,
    required this.total,
    required this.sales,
  });
  late final bool btnPermission;
  late final int total;
  late final List<Sales> sales;

  WarehouseSalesModel.fromJson(Map<String, dynamic> json){
    btnPermission = json['AddRequestPermission'];
    total = json['total'];
    sales = List.from(json['sales']).map((e)=>Sales.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['AddRequestPermission'] = btnPermission;
    data['total'] = total;
    data['sales'] = sales.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Sales {
  Sales({
    required this.id,
    required this.invoiceId,
    this.typeName,
    this.statusName,
    this.saleChannelName,
    this.address,
    this.parentData,
    this.managerName,
    this.clientName,
    this.totalPrice,
    this.createdAt,
    this.source,
    this.kaspiNum,
  });
  late final int id;
  late final String invoiceId;
  late final String? typeName;
  late final String? statusName;
  late final String? saleChannelName;
  late final String? address;
  late final String? parentData;
  late final String? managerName;
  late final String? clientName;
  late final totalPrice;
  late final String? createdAt;
  late final String? source;
  late final String? kaspiNum;
  late final bool? isLate;

  Sales.fromJson(Map<String, dynamic> json){
    id = json['id'];
    invoiceId = json['invoice_id'];
    typeName = json['typeName'];
    statusName = json['statusName'];
    saleChannelName = json['saleChannelName'];
    address = json['address'];
    parentData = json['parent_data'];
    managerName = json['manager_name'];
    clientName = json['client_name'];
    totalPrice = json['totalPrice'];
    createdAt = json['created_at'];
    source = json['source'];
    kaspiNum = json['kaspi_num'];
    isLate = json['is_late'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_id'] = invoiceId;
    data['typeName'] = typeName;
    data['statusName'] = statusName;
    data['saleChannelName'] = saleChannelName;
    data['parent_data'] = parentData;
    data['manager_name'] = managerName;
    data['client_name'] = clientName;
    data['totalPrice'] = totalPrice;
    data['created_at'] = createdAt;
    data['source'] = source;
    data['kaspi_num'] = kaspiNum;
    data['is_late'] = isLate;
    return data;
  }
}