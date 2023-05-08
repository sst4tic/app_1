class WarehouseCategory {
  final int id;
  final String name;
  final List<Child>? child;

  WarehouseCategory({
   required this.id,
   required this.name,
    this.child,
  });

  WarehouseCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        child = (json['child'] as List?)
            ?.map((dynamic e) => Child.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'child': child?.map((e) => e.toJson()).toList()};
}

class Child {
  final int? id;
  final String? name;

  Child({
    this.id,
    this.name,
  });

  Child.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
