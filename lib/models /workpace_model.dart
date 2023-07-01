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

  WorkpaceModel.fromJson(Map<String, dynamic> json){
    totalWork = json['total_work'];
    todayWork = json['today_work'];
    comingToday = json['coming_today'];
    leavingToday = json['leaving_today'];
    btnType = json['btn_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_work'] = totalWork;
    data['today_work'] = todayWork;
    data['coming_today'] = comingToday;
    data['leaving_today'] = leavingToday;
    data['btn_type'] = btnType;
    return data;
  }
}