class CommentModel {
  CommentModel({
    required this.id,
    required this.message,
    required this.name,
    required this.dateAt,
    required this.createdAt,
  });
  late final int id;
  late final String message;
  late final String name;
  late final String dateAt;
  late final String createdAt;

  CommentModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    message = json['message'];
    name = json['name'];
    dateAt = json['date_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['name'] = name;
    data['date_at'] = dateAt;
    data['created_at'] = createdAt;
    return data;
  }
}