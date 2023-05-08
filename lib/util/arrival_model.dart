class ArrivalModel {
  ArrivalModel({
    required this.id,
    required this.managerName,
    required this.warehouseName,
    required this.createdAt,
  });
  late final int id;
  late final String managerName;
  late final String warehouseName;
  late final String createdAt;

  ArrivalModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    managerName = json['manager_name'];
    warehouseName = json['warehouse_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['manager_name'] = managerName;
    data['warehouse_name'] = warehouseName;
    data['created_at'] = createdAt;
    return data;
  }
}