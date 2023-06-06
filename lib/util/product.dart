class Product {
  final int id;
  final String? sku;
  final String name;
  final String? categoryName;
  final String price;
  final bool? hasMedia;
  final List<Availability>? availability;

  Product({
    required this.id,
    this.sku,
    required this.name,
    this.categoryName,
    required this.price,
    this.hasMedia,
    this.availability,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        sku = json['sku'] as String?,
        name = json['name'],
        categoryName = json['category_name'],
        price = json['price'],
        hasMedia = json['has_media'],
        availability = (json['availability'] as List?)
            ?.map((e) => Availability.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'sku': sku,
        'name': name,
        'category_name': categoryName,
        'price': price,
        'has_media': hasMedia,
        'availability': availability?.map((e) => e.toJson()).toList()
      };
}

class Availability {
  final String? name;
  final String? location;

  Availability({
    this.name,
    this.location
  });

  Availability.fromJson(Map<String, dynamic> json)
      :
        name = json['name'] as String?,
        location = json['location'] ?? '';
  Map<String, dynamic> toJson() => {'name': name, 'location': location};
}
