class ArrivalExistenceModel {
  ArrivalExistenceModel({
    required this.exists,
    required this.product,
    required this.availability,
  });
  late final bool exists;
  late final Product product;
  late final List<String> availability;

  ArrivalExistenceModel.fromJson(Map<String, dynamic> json){
    exists = json['exists'];
    product = Product.fromJson(json['product']);
    availability = List.castFrom<dynamic, String>(json['availability']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['exists'] = exists;
    data['product'] = product.toJson();
    data['availability'] = availability;
    return data;
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
  });
  late final int id;
  late final String name;
  late final int price;

  Product.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}