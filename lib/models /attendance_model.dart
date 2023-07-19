class AttendanceModel {
  AttendanceModel({
    required this.day,
    this.inAt,
    this.outAt,
    this.startSchedule,
    this.endSchedule,
    required this.dayOff,
  });
  late final String day;
  late final String? inAt;
  late final String? outAt;
  late final String? startSchedule;
  late final String? endSchedule;
  late final bool dayOff;

  AttendanceModel.fromJson(Map<String, dynamic> json){
    day = json['day'];
    inAt = json['in_at'];
    outAt = json['out_at'];
    startSchedule = json['start_schedule'];
    endSchedule = json['end_schedule'];
    dayOff = json['is_dayoff'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['in_at'] = inAt;
    data['out_at'] = outAt;
    data['start_schedule'] = startSchedule;
    data['end_schedule'] = endSchedule;
    data['is_dayoff'] = dayOff;
    return data;
  }
}