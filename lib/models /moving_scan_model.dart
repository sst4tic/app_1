class MovingScanModel {
  MovingScanModel({
    required this.name,
    required this.sku,
    required this.qty,
    required this.qtyScanned,
  });
  late final String name;
  late final String sku;
  late final int qty;
  late final int qtyScanned;

  MovingScanModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    sku = json['sku'];
    qty = json['qty'];
    qtyScanned = json['qty_scanned'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['sku'] = sku;
    data['qty'] = qty;
    data['qty_scanned'] = qtyScanned;
    return data;
  }
}