import 'package:yiwucloud/util/filter_list_model.dart';

class ProductFilterModel {
  ProductFilterModel({
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });

  var value;
  String? name;
  var initialValue;
  late final  List<ChildData> childData;

  ProductFilterModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data'])
        .map((e) => ChildData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e) => e.toJson()).toList();
    return data;
  }
}
