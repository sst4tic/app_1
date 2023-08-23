
class ArrivalDetailsModel {
  ArrivalDetailsModel({
    required this.id,
    required this.manager,
    required this.warehouse,
    required this.createdAt,
    required this.printURL,
    this.comments,
    required this.products,
  });
  late final int id;
  late final String manager;
  late final String warehouse;
  late final String createdAt;
  late final String printURL;
  late final String? comments;
  late final List<Products> products;

  ArrivalDetailsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    manager = json['manager'];
    warehouse = json['warehouse'];
    createdAt = json['created_at'];
    printURL = json['printURL'];
    comments = json['comments'];
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['manager'] = manager;
    _data['warehouse'] = warehouse;
    _data['created_at'] = createdAt;
    _data['printURL'] = printURL;
    _data['comments'] = comments;
    _data['products'] = products.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Products {
  Products({
    required this.name,
    required this.sku,
    required this.qty,
    required this.price,
  });
  late final String name;
  late final String sku;
  late final qty;
  late final price;

  Products.fromJson(Map<String, dynamic> json){
    name = json['name'];
    sku = json['sku'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['sku'] = sku;
    _data['qty'] = qty;
    _data['price'] = price;
    return _data;
  }
}