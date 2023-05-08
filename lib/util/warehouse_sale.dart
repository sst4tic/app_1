class WarehouseSalesModel {
  WarehouseSalesModel({
    required this.id,
    required this.invoiceId,
    required this.typeName,
    required this.statusName,
    this.saleChannelName,
    required this.managerName,
    required this.clientName,
    required this.totalPrice,
    required this.createdAt,
    required this.source,
  });
  late final int id;
  late final String invoiceId;
  late final String typeName;
  late final String statusName;
  String? saleChannelName;
  late final String managerName;
  late final String clientName;
  late final int totalPrice;
  late final String createdAt;
  late final String source;

  WarehouseSalesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    invoiceId = json['invoice_id'];
    typeName = json['typeName'];
    statusName = json['statusName'];
    saleChannelName = json['saleChannelName'];
    managerName = json['manager_name'];
    clientName = json['client_name'];
    totalPrice = json['totalPrice'];
    createdAt = json['created_at'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_id'] = invoiceId;
    data['typeName'] = typeName;
    data['statusName'] = statusName;
    data['saleChannelName'] = saleChannelName;
    data['manager_name'] = managerName;
    data['client_name'] = clientName;
    data['totalPrice'] = totalPrice;
    data['created_at'] = createdAt;
    data['source'] = source;
    return data;
  }
}