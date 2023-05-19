class ChronologyModel {
  ChronologyModel({
    this.status,
    required this.message,
    required this.name,
    required this.createdAt,
  });
  late final int? status;
  late final String message;
  late final String name;
  late final String createdAt;

  ChronologyModel.fromJson(Map<String, dynamic> json){
    status = null;
    message = json['message'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['name'] = name;
    data['created_at'] = createdAt;
    return data;
  }
}