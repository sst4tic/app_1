class AttendanceModel {
  AttendanceModel({
    required this.day,
    this.inAt,
    this.outAt,
  });
  late final String day;
  late final String? inAt;
  late final String? outAt;

  AttendanceModel.fromJson(Map<String, dynamic> json){
    day = json['day'];
    inAt = json['in_at'];
    outAt = json['out_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['in_at'] = inAt;
    data['out_at'] = outAt;
    return data;
  }
}