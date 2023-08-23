class OperationModel {
  OperationModel({
    required this.totalSumIncome,
    required this.totalSumExpense,
    required this.totalSaldo,
    required this.count,
    required this.movingBtn,
    required this.addBtn,
    required this.operations,
  });
  late final String totalSumIncome;
  late final String totalSumExpense;
  late final String totalSaldo;
  late final int count;
  late final bool movingBtn;
  late final bool addBtn;
  late final List<Operations> operations;

  OperationModel.fromJson(Map<String, dynamic> json){
    totalSumIncome = json['total_sum_income'];
    totalSumExpense = json['total_sum_expense'];
    totalSaldo = json['total_saldo'];
    count = json['count'];
    movingBtn = json['moving_btn'];
    addBtn = json['add_btn'];
    operations = List.from(json['operations']).map((e)=>Operations.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_sum_income'] = totalSumIncome;
    _data['total_sum_expense'] = totalSumExpense;
    _data['total_saldo'] = totalSaldo;
    _data['count'] = count;
    _data['moving_btn'] = movingBtn;
    _data['add_btn'] = addBtn;
    _data['operations'] = operations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Operations {
  Operations({
    this.invoiceUrl,
    required this.id,
    required this.billName,
    this.comments,
    this.invoiceId,
    required this.isMoving,
    required this.typeName,
    required this.type,
    this.articleName,
    required this.totalSum,
    required this.managerName,
    required this.createdAt,
  });
  late final String? invoiceUrl;
  late final int id;
  late final String billName;
  late final String? comments;
  late final String? invoiceId;
  late final int isMoving;
  late final String typeName;
  late final int type;
  late final String? articleName;
  late final String totalSum;
  late final String managerName;
  late final String createdAt;

  Operations.fromJson(Map<String, dynamic> json){
    invoiceUrl = json['invoice_url'];
    id = json['id'];
    billName = json['bill_name'];
    comments = json['comments'];
    invoiceId = json['invoice_id'];
    isMoving = json['is_moving'];
    typeName = json['type_name'];
    type = json['type'];
    articleName = json['article_name'];
    totalSum = json['total_sum'];
    managerName = json['manager_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['invoice_url'] = invoiceUrl;
    _data['id'] = id;
    _data['bill_name'] = billName;
    _data['comments'] = comments;
    _data['invoice_id'] = invoiceId;
    _data['is_moving'] = isMoving;
    _data['type_name'] = typeName;
    _data['type'] = type;
    _data['article_name'] = articleName;
    _data['total_sum'] = totalSum;
    _data['manager_name'] = managerName;
    _data['created_at'] = createdAt;
    return _data;
  }
}