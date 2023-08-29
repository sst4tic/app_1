class OperationSalesModel {
  OperationSalesModel({
    required this.operations,
    required this.totalPriceBills,
  });
  late final List<Operations> operations;
  late final String totalPriceBills;

  OperationSalesModel.fromJson(Map<String, dynamic> json){
    operations = List.from(json['operations']).map((e)=>Operations.fromJson(e)).toList();
    totalPriceBills = json['totalPriceBills'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['operations'] = operations.map((e)=>e.toJson()).toList();
    _data['totalPriceBills'] = totalPriceBills;
    return _data;
  }
}

class Operations {
  Operations({
    required this.id,
    required this.typeName,
    required this.totalSum,
    required this.billName,
    required this.managerName,
    required this.createdAt,
    required this.btnRemove,
  });
  late final int id;
  late final String typeName;
  late final String totalSum;
  late final String billName;
  late final String managerName;
  late final String createdAt;
  late final bool btnRemove;

  Operations.fromJson(Map<String, dynamic> json){
    id = json['id'];
    typeName = json['typeName'];
    totalSum = json['total_sum'];
    billName = json['billName'];
    managerName = json['manager_name'];
    createdAt = json['created_at'];
    btnRemove = json['btnRemove'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['typeName'] = typeName;
    _data['total_sum'] = totalSum;
    _data['billName'] = billName;
    _data['manager_name'] = managerName;
    _data['created_at'] = createdAt;
    _data['btnRemove'] = btnRemove;
    return _data;
  }
}