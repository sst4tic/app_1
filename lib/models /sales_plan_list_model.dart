class SalesPlanListModel {
  SalesPlanListModel({
    required this.hash,
    required this.name,
    required this.totalAmount,
    required this.succeedAmount,
  });
  late final String hash;
  late final String name;
  late final String totalAmount;
  late final String succeedAmount;

  SalesPlanListModel.fromJson(Map<String, dynamic> json){
    hash = json['hash'];
    name = json['name'];
    totalAmount = json['total_amount'];
    succeedAmount = json['succeed_amount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['hash'] = hash;
    data['name'] = name;
    data['total_amount'] = totalAmount;
    data['succeed_amount'] = succeedAmount;
    return data;
  }
}