class ScheduleModel {
  ScheduleModel({
    required this.day,
    this.startAt,
    this.endAt,
    required this.isDayoff,
  });
  late final String day;
  late final String? startAt;
  late final String? endAt;
  late final bool isDayoff;

  ScheduleModel.fromJson(Map<String, dynamic> json){
    day = json['day'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    isDayoff = json['is_dayoff'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['is_dayoff'] = isDayoff;
    return data;
  }
}