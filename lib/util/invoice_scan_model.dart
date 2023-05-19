
class InvoiceScanModel {
  InvoiceScanModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.qty,
    required this.qtyScanned,
    this.managerName,
    this.scannedAt,
  });
  late final int id;
  late final String name;
  late final String sku;
  late final int qty;
  late final int qtyScanned;
  late final String? managerName;
  late final String? scannedAt;

  InvoiceScanModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    sku = json['sku'];
    qty = json['qty'];
    qtyScanned = json['qty_scanned'];
    managerName = json['manager_name'];
    scannedAt = json['scanned_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sku'] = sku;
    data['qty'] = qty;
    data['qty_scanned'] = qtyScanned;
    data['manager_name'] = managerName;
    data['scanned_at'] = scannedAt;
    return data;
  }
}