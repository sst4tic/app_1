class ProductDetails {
  ProductDetails({
    required this.id,
    required this.name,
    required final String createdAt,
    required this.sku,
    this.description,
    required this.media,
    this.totalCount,
    required this.price,
    required this.editPermission,
    this.availability,
    this.inSale,
    this.preorders,
  });

  late final int id;
  late final String name;
  String? createdAt;
  late final sku;
  late final int price;
  late final String? description;
  late final List<Media> media;
  late final int? totalCount;
  late final bool editPermission;
  late final Availability? availability;
  late final InSale? inSale;
  late final Preorders? preorders;

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    sku = json['sku'];
    price = json['price_retail'];
    description = json['description'];
    media = json['media']
        .map<Media>((json) => Media.fromJson(json))
        .toList();
    totalCount = json['warehouse_total_count'];
    editPermission = json['locationEditBtn'];
    availability = json['availability'] != null ? Availability.fromJson(json['availability']) : null;
    inSale = json['in_sale'] != null ? InSale.fromJson(json['in_sale']) : null;
    preorders = json['preorders'] != null ? Preorders.fromJson(json['preorders']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['sku'] = sku;
    data['price_retail'] = price;
    data['description'] = description;
    data['media'] = media.map((e) => e.toJson()).toList();
    data['warehouse_total_count'] = totalCount;
    data['locationEditBtn'] = editPermission;
    return data;
  }
}

class Media {
  Media({
    required this.full,
    required this.thumbnails,
  });

  late final String full;
  late final Thumbnails thumbnails;

  Media.fromJson(Map<String, dynamic> json) {
    full = json['full'];
    thumbnails = Thumbnails.fromJson(json['thumbnails']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['full'] = full;
    data['thumbnails'] = thumbnails.toJson();
    return data;
  }
}

class Thumbnails {
  Thumbnails({
    required this.s150,
    required this.s350,
    required this.s750,
  });

  late final String s150;
  late final String s350;
  late final String s750;

  Thumbnails.fromJson(Map<String, dynamic> json) {
    s150 = json['150'];
    s350 = json['350'];
    s750 = json['750'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['150'] = s150;
    data['350'] = s350;
    data['750'] = s750;
    return data;
  }
}

class Warehouses {
  Warehouses({
    required this.id,
    required this.count,
    required this.name,
    required this.updatedAt,
    this.location
  });

  late final int id;
  late final int count;
  late final String name;
  late final String updatedAt;
  late final String? location;

  Warehouses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    name = json['warehouse_name'];
    updatedAt = json['updated_at'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['count'] = count;
    data['warehouse_name'] = name;
    data['updated_at'] = updatedAt;
    data['location'] = location;
    return data;
  }
}

class Availability {
  Availability({
    required this.total,
    required this.list,
  });
  late final int total;
  late final List<ListModel> list;

  Availability.fromJson(Map<String, dynamic> json){
    total = json['total'];
    list = List.from(json['list']).map((e)=>ListModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total'] = total;
    data['list'] = list.map((e)=>e.toJson()).toList();
    return data;
  }
}

class InSale {
  InSale({
    required this.total,
    required this.list,
  });
  late final int total;
  late final List<ListModel> list;

  InSale.fromJson(Map<String, dynamic> json){
    total = json['total'];
    list = List.from(json['list']).map((e)=>ListModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total'] = total;
    data['list'] = list.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Preorders {
  Preorders({
    required this.total,
    required this.list,
  });
  late final int total;
  late final List<ListModel> list;

  Preorders.fromJson(Map<String, dynamic> json){
    total = json['total'];
    list = List.from(json['list']).map((e)=>ListModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total'] = total;
    data['list'] = list.map((e)=>e.toJson()).toList();
    return data;
  }
}


class ListModel {
  ListModel({
     this.name,
     this.wId,
     this.qty,
     this.id,
     this.invoiceId,
  });
  late final String? name;
  late final int? wId;
  late final int? qty;
  late final int? id;
  late final String? invoiceId;

  ListModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    wId = json['w_id'];
    qty = json['qty'];
    id = json['id'];
    invoiceId = json['invoice_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['w_id'] = wId;
    _data['qty'] = qty;
    _data['id'] = id;
    _data['invoice_id'] = invoiceId;
    return _data;
  }
}


class ProductDetailsWithWarehouses {
  final ProductDetails data;
  final List<Warehouses> warehouses;

  ProductDetailsWithWarehouses({required this.data, required this.warehouses});
}
