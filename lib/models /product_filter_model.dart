import 'package:hive/hive.dart';
part 'product_filter_model.g.dart';


@HiveType(typeId: 1)
class ProductFilterModel extends HiveObject {
  ProductFilterModel({
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });

  @HiveField(0)
  late dynamic value;

  @HiveField(1)
  String? name;

  @HiveField(2)
  late dynamic initialValue;

  @HiveField(3)
  late List<ChildDataProduct> childData;

  ProductFilterModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data'])
        .map((e) => ChildDataProduct.fromJson(e))
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

@HiveType(typeId: 2)
class ChildDataProduct extends HiveObject {
  ChildDataProduct({
    required this.value,
    required this.text,
  });
  late final dynamic value;
  late final String text;

  ChildDataProduct.fromJson(Map<String, dynamic> json){
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
