class Logs {
  Logs({
    required this.type,
    required this.recorder,
    this.qtyOld,
    this.qtyNew,
    required this.createdAt,
    this.qty,
  });

  late final String type;
  late final String recorder;
  late final qtyOld;
  late final qtyNew;
  late final String createdAt;
  late final String? qty;

  Logs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    recorder = json['recorder'];
    qtyOld = json['qty_old'];
    qtyNew = json['qty_new'];
    createdAt = json['created_at'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['recorder'] = recorder;
    data['qty_old'] = qtyOld;
    data['qty_new'] = qtyNew;
    data['created_at'] = createdAt;
    data['qty'] = qty;
    return data;
  }
}

