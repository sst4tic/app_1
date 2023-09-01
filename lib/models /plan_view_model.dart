class PlanViewModel {
  PlanViewModel({
    required this.name,
    required this.total,
    required this.managers,
  });
  late final String name;
  late final Total total;
  late final List<Managers> managers;

  PlanViewModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    total = Total.fromJson(json['total']);
    managers = List.from(json['managers']).map((e)=>Managers.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['total'] = total.toJson();
    data['managers'] = managers.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Total {
  Total({
    required this.percent,
    required this.totalAmount,
    required this.salesTotal,
  });
  late final int percent;
  late final String totalAmount;
  late final String salesTotal;

  Total.fromJson(Map<String, dynamic> json){
    percent = json['percent'];
    totalAmount = json['totalAmount'];
    salesTotal = json['salesTotal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['percent'] = percent;
    data['totalAmount'] = totalAmount;
    data['salesTotal'] = salesTotal;
    return data;
  }
}

class Managers {
  Managers({
    required this.name,
    required this.vertLine,
    required this.percent,
    required this.planAmount,
    required this.salesTotal,
  });
  late final String name;
  late final vertLine;
  late final percent;
  late final String planAmount;
  late final String salesTotal;

  Managers.fromJson(Map<String, dynamic> json){
    name = json['name'];
    vertLine = json['vertLine'];
    percent = json['percent'];
    planAmount = json['planAmount'];
    salesTotal = json['salesTotal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['vertLine'] = vertLine;
    data['percent'] = percent;
    data['planAmount'] = planAmount;
    data['salesTotal'] = salesTotal;
    return data;
  }
}