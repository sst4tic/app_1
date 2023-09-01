class OperationModel {
  OperationModel({
    required this.totalSumIncome,
    required this.totalSumExpense,
    required this.totalSaldo,
    required this.count,
    required this.movingBtn,
    required this.addBtn,
    required this.deleteBtn,
    required this.operations,
  });

  late final String totalSumIncome;
  late final String totalSumExpense;
  late final String totalSaldo;
  late final int count;
  late final bool movingBtn;
  late final bool addBtn;
  late final bool deleteBtn;
  late final List<Operations> operations;

  OperationModel.fromJson(Map<String, dynamic> json) {
    totalSumIncome = json['total_sum_income'];
    totalSumExpense = json['total_sum_expense'];
    totalSaldo = json['total_saldo'];
    count = json['count'];
    movingBtn = json['moving_btn'];
    addBtn = json['add_btn'];
    deleteBtn = json['delete_btn'];
    operations = List.from(json['operations'])
        .map((e) => Operations.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_sum_income'] = totalSumIncome;
    data['total_sum_expense'] = totalSumExpense;
    data['total_saldo'] = totalSaldo;
    data['count'] = count;
    data['moving_btn'] = movingBtn;
    data['add_btn'] = addBtn;
    data['delete_btn'] = deleteBtn;
    data['operations'] = operations.map((e) => e.toJson()).toList();
    return data;
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
    required this.isDeleted,
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
  late final bool isDeleted;

  Operations.fromJson(Map<String, dynamic> json) {
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
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['invoice_url'] = invoiceUrl;
    data['id'] = id;
    data['bill_name'] = billName;
    data['comments'] = comments;
    data['invoice_id'] = invoiceId;
    data['is_moving'] = isMoving;
    data['type_name'] = typeName;
    data['type'] = type;
    data['article_name'] = articleName;
    data['total_sum'] = totalSum;
    data['manager_name'] = managerName;
    data['created_at'] = createdAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
