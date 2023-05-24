class AnalyticsTopSalesModel {
  AnalyticsTopSalesModel({
    required this.channelsList,
    required this.totalSum,
    required this.totalSumLastPeriod,
    required this.totalSumReturns,
    required this.managersList,
    required this.managersCount,
  });

  late final List<ChannelsList> channelsList;
  late final String totalSum;
  late final String totalSumLastPeriod;
  late final String totalSumReturns;
  late final List<ManagersList> managersList;
  late final String managersCount;

  AnalyticsTopSalesModel.fromJson(Map<String, dynamic> json) {
    channelsList = List.from(json['channels_list'])
        .map((e) => ChannelsList.fromJson(e))
        .toList();
    totalSum = json['total_sum'];
    totalSumLastPeriod = json['total_sum_last_period'];
    totalSumReturns = json['total_sum_returns'];
    managersList = List.from(json['managers_list'])
        .map((e) => ManagersList.fromJson(e))
        .toList();
    managersCount = json['managers_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['channels_list'] = channelsList.map((e) => e.toJson()).toList();
    _data['total_sum'] = totalSum;
    _data['total_sum_last_period'] = totalSumLastPeriod;
    _data['total_sum_returns'] = totalSumReturns;
    _data['managers_list'] = managersList.map((e) => e.toJson()).toList();
    _data['managers_count'] = managersCount;
    return _data;
  }
}

class ChannelsList {
  ChannelsList({
    required this.name,
    required this.totalSum,
    required this.totalSumLastPeriod,
    required this.totalSumDifferencePercentage,
    required this.totalSumReturns,
    required this.plan,
    required this.planPercentage,
  });

  late final String name;
  late final  totalSum;
  late final int totalSumLastPeriod;
  late final int totalSumDifferencePercentage;
  late final int totalSumReturns;
  late final int plan;
  late final  planPercentage;

  ChannelsList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSum = json['total_sum'];
    totalSumLastPeriod = json['total_sum_last_period'];
    totalSumDifferencePercentage = json['total_sum_difference_percentage'];
    totalSumReturns = json['total_sum_returns'];
    plan = json['plan'];
    planPercentage = json['plan_percentage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['total_sum'] = totalSum;
    _data['total_sum_last_period'] = totalSumLastPeriod;
    _data['total_sum_difference_percentage'] = totalSumDifferencePercentage;
    _data['total_sum_returns'] = totalSumReturns;
    _data['plan'] = plan;
    _data['plan_percentage'] = planPercentage;
    return _data;
  }
}

class ManagersList {
  ManagersList({
    required this.fullName,
    required this.channelName,
    required this.channelId,
    required this.totalSum,
    required this.totalSumLastPeriod,
    required this.totalSumDifferencePercentage,
    required this.totalSumReturns,
    required this.plan,
    required this.planPercentage,
  });

  late final String fullName;
  late final String channelName;
  late final int channelId;
  late final  totalSum;
  late final int totalSumLastPeriod;
  late final int totalSumDifferencePercentage;
  late final int totalSumReturns;
  late final int plan;
  late final planPercentage;

  ManagersList.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    channelName = json['channel_name'];
    channelId = json['channel_id'];
    totalSum = json['total_sum'];
    totalSumLastPeriod = json['total_sum_last_period'];
    totalSumDifferencePercentage = json['total_sum_difference_percentage'];
    totalSumReturns = json['total_sum_returns'];
    plan = json['plan'];
    planPercentage = json['plan_percentage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['full_name'] = fullName;
    _data['channel_name'] = channelName;
    _data['channel_id'] = channelId;
    _data['total_sum'] = totalSum;
    _data['total_sum_last_period'] = totalSumLastPeriod;
    _data['total_sum_difference_percentage'] = totalSumDifferencePercentage;
    _data['total_sum_returns'] = totalSumReturns;
    _data['plan'] = plan;
    _data['plan_percentage'] = planPercentage;
    return _data;
  }
}
