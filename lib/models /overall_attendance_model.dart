class OverallAttendanceModel {
  OverallAttendanceModel({
    this.channelName,
    this.name,
    this.surname,
    this.roleName,
    this.inAt,
    this.overtiming,
    this.earlyArrival,
    this.outAt,
    this.lateness,
    this.lonIn,
    this.latIn,
    this.lonOut,
    this.latOut,
    this.worked,
  });
  late final String? channelName;
  late final String? name;
  late final String? surname;
  late final String? roleName;
  late final String? inAt;
  late final String? overtiming;
  late final String? earlyArrival;
  late final String? outAt;
  late final String? lateness;
  late final String? lonIn;
  late final String? latIn;
  late final String? lonOut;
  late final String? latOut;
  late final worked;

  OverallAttendanceModel.fromJson(Map<String, dynamic> json){
    channelName = json['channelName'];
    name = json['name'];
    surname = json['surname'];
    roleName = json['roleName'];
    inAt = json['in_at'];
    overtiming = json['overtiming'];
    earlyArrival = json['early_arrival'];
    outAt = json['out_at'];
    lateness = json['lateness'];
    lonIn = json['lon_in'];
    latIn = json['lat_in'];
    lonOut = json['lon_out'];
    latOut = json['lat_out'];
    worked = json['worked'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["channelName"] = channelName;
    data['name'] = name;
    data['surname'] = surname;
    data['roleName'] = roleName;
    data['in_at'] = inAt;
    data['overtiming'] = overtiming;
    data['early_arrival'] = earlyArrival;
    data['out_at'] = outAt;
    data['lateness'] = lateness;
    data['lon_in'] = lonIn;
    data['lat_in'] = latIn;
    data['lon_out'] = lonOut;
    data['lat_out'] = latOut;
    data['worked'] = worked;
    return data;
  }
}