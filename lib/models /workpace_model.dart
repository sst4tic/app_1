class WorkpaceModel {
  WorkpaceModel({
    required this.totalWork,
    required this.todayWork,
    required this.comingToday,
    this.leavingToday,
    required this.btnType,
  });
  late final String? totalWork;
  late final String? todayWork;
  late final String? comingToday;
  late final String? leavingToday;
  late final String? btnType;
  late final String? startAt;
  late final String? endAt;
  late final String? schedule;
  late final String overtime;
  late final String earlyArrival;
  late final String lateness;

  WorkpaceModel.fromJson(Map<String, dynamic> json){
    totalWork = json['total_work'];
    todayWork = json['today_work'];
    comingToday = json['coming_today'];
    leavingToday = json['leaving_today'];
    btnType = json['btn_type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    schedule = json['schedule'];
    overtime = json['overtiming'];
    earlyArrival = json['early_arrival'];
    lateness = json['lateness'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_work'] = totalWork;
    data['today_work'] = todayWork;
    data['coming_today'] = comingToday;
    data['leaving_today'] = leavingToday;
    data['btn_type'] = btnType;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['schedule'] = schedule;
    data['overtiming'] = overtime;
    data['early_arrival'] = earlyArrival;
    data['lateness'] = lateness;
    return data;
  }
}