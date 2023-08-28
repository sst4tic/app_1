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
  late final List<Locations> locations;

  AttendanceModel.fromJson(Map<String, dynamic> json){
    day = json['day'];
    inAt = json['in_at'];
    outAt = json['out_at'];
    startSchedule = json['start_schedule'];
    endSchedule = json['end_schedule'];
    dayOff = json['is_dayoff'];
    locations = json['locations']
        .map<Locations>((json) => Locations.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['in_at'] = inAt;
    data['out_at'] = outAt;
    data['start_schedule'] = startSchedule;
    data['end_schedule'] = endSchedule;
    data['is_dayoff'] = dayOff;
    data['locations'] = locations.map((e) => e.toJson()).toList();
    return data;
  }
}

class Locations {
  Locations({
    required this.lat,
    required this.lon,
    required this.createdAt,
  });
  late final String lat;
  late final String lon;
  late final String createdAt;

  Locations.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lon = json['lon'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['created_at'] = createdAt;
    return data;
  }
}