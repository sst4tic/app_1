class AnalyticsTopSalesModel {
  AnalyticsTopSalesModel({
    this.channelsList,
    this.totalSum,
    // required this.totalSumLastPeriod,
    this.totalSumReturns,
    this.managersList,
    this.managersCount,
  });

  late final List<ChannelsList>? channelsList;
  late final String? totalSum;
  // late final String totalSumLastPeriod;
  late final String? totalSumReturns;
  late final List<ManagersList>? managersList;
  late final String? managersCount;

  AnalyticsTopSalesModel.fromJson(Map<String, dynamic> json) {
    channelsList = List.from(json['channels_list'] ?? [])
        .map((e) => ChannelsList.fromJson(e))
        .toList();
    totalSum = json['total_sum'] ?? '';
    // totalSumLastPeriod = json['total_sum_last_period'];
    totalSumReturns = json['total_sum_returns'] ?? '';
    managersList = List.from(json['managers_list'] ?? [])
        .map((e) => ManagersList.fromJson(e))
        .toList();
    managersCount = json['managers_count'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['channels_list'] = channelsList?.map((e) => e.toJson()).toList();
    data['total_sum'] = totalSum;
    // _data['total_sum_last_period'] = totalSumLastPeriod;
    data['total_sum_returns'] = totalSumReturns;
    data['managers_list'] = managersList?.map((e) => e.toJson()).toList();
    data['managers_count'] = managersCount;
    return data;
  }
}

class ChannelsList {
  ChannelsList({
    required this.name,
    required this.totalSum,
    // required this.totalSumLastPeriod,
    // required this.totalSumDifferencePercentage,
    required this.totalSumReturns,
    required this.plan,
    required this.planPercentage,
  });

  late final String name;
  late final String totalSum;
  late final totalSumReturns;
  late final String plan;
  late final  planPercentage;

  ChannelsList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSum = json['total_sum'];
    totalSumReturns = json['total_sum_returns'];
    plan = json['plan'];
    planPercentage = json['plan_percentage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['total_sum'] = totalSum;
    // _data['total_sum_last_period'] = totalSumLastPeriod;
    // _data['total_sum_difference_percentage'] = totalSumDifferencePercentage;
    data['total_sum_returns'] = totalSumReturns;
    data['plan'] = plan;
    data['plan_percentage'] = planPercentage;
    return data;
  }
}

class ManagersList {
  ManagersList({
    required this.fullName,
    required this.channelName,
    required this.channelId,
    required this.totalSum,
    // required this.totalSumLastPeriod,
    // required this.totalSumDifferencePercentage,
    required this.totalSumReturns,
    required this.plan,
    required this.planPercentage,
  });

  late final String fullName;
  late final String channelName;
  late final int channelId;
  late final String totalSum;
  // late final int totalSumLastPeriod;
  // late final int totalSumDifferencePercentage;
  late final totalSumReturns;
  late final String plan;
  late final planPercentage;

  ManagersList.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    channelName = json['channel_name'];
    channelId = json['channel_id'];
    totalSum = json['total_sum'];
    // totalSumLastPeriod = json['total_sum_last_period'];
    // totalSumDifferencePercentage = json['total_sum_difference_percentage'];
    totalSumReturns = json['total_sum_returns'];
    plan = json['plan'];
    planPercentage = json['plan_percentage'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['channel_name'] = channelName;
    data['channel_id'] = channelId;
    data['total_sum'] = totalSum;
    // _data['total_sum_last_period'] = totalSumLastPeriod;
    // _data['total_sum_difference_percentage'] = totalSumDifferencePercentage;
    data['total_sum_returns'] = totalSumReturns;
    data['plan'] = plan;
    data['plan_percentage'] = planPercentage;
    return data;
  }
}
