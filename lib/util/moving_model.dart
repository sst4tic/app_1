class MovingModel {
  MovingModel({
    required this.movingId,
    required this.statusName,
    required this.warehouseFromData,
    required this.warehouseToData,
    required this.senderData,
    required this.createdAt,
  });
  late final String movingId;
  late final String statusName;
  late final String warehouseFromData;
  late final String warehouseToData;
  late final String senderData;
  late final String createdAt;

  MovingModel.fromJson(Map<String, dynamic> json){
    movingId = json['moving_id'];
    statusName = json['status_name'];
    warehouseFromData = json['warehouseFromData'];
    warehouseToData = json['warehouseToData'];
    senderData = json['senderData'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['moving_id'] = movingId;
    data['status_name'] = statusName;
    data['warehouseFromData'] = warehouseFromData;
    data['warehouseToData'] = warehouseToData;
    data['senderData'] = senderData;
    data['created_at'] = createdAt;
    return data;
  }
}