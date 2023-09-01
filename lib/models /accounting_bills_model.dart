class BillsModel {
  BillsModel({
    required this.totalCount,
    required this.totalSum,
    required this.btnEdit,
    required this.btnAdd,
    required this.bills,
  });
  late final int totalCount;
  late final String totalSum;
  late final bool btnEdit;
  late final bool btnAdd;
  late final List<Bills> bills;

  BillsModel.fromJson(Map<String, dynamic> json){
    totalCount = json['totalCount'];
    totalSum = json['totalSum'];
    btnEdit = json['btnEdit'];
    btnAdd = json['btnAdd'];
    bills = List.from(json['bills']).map((e)=>Bills.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['totalSum'] = totalSum;
    data['btnEdit'] = btnEdit;
    data['btnAdd'] = btnAdd;
    data['bills'] = bills.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Bills {
  Bills({
    required this.id,
    required this.name,
    required this.type,
    required this.sum,
  });
  late final int id;
  late final String name;
  late final String type;
  late final int sum;

  Bills.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['sum'] = sum;
    return data;
  }
}