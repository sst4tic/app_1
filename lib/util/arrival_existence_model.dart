class ArrivalExistenceModel {
  ArrivalExistenceModel({
    required this.exists,
     this.product,
     this.availability,
  });
  late final bool exists;
  late final Product? product;
  late final List<String>? availability;

  ArrivalExistenceModel.fromJson(Map<String, dynamic> json){
    exists = json['exists'];
    product = json['product'] != null ?  Product.fromJson(json['product']) : null;
    availability = json['availability'] != null ? List<String>.from(json['availability']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exists'] = exists;
    data['product'] = product?.toJson();
    data['availability'] = availability;
    return data;
  }
}

class Product {
  Product({
    required this.id,
    required this.sku,
    required this.name,
  });
  late final int id;
  late final String sku;
  late final String name;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['sku'] = sku;
    data['name'] = name;
    return data;
  }
}