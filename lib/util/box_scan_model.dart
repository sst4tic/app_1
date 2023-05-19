class BoxScanModel {
  BoxScanModel({
    required this.barcode,
    required this.qty,
    required this.qtyScanned,
    this.managerName,
    this.scannedAt,
  });
  late final String barcode;
  late final int qty;
  late final int qtyScanned;
  late final String? managerName;
  late final String? scannedAt;

  BoxScanModel.fromJson(Map<String, dynamic> json){
    barcode = json['barcode'];
    qty = json['qty'] ?? 1;
    qtyScanned = json['qty_scanned'];
    managerName = json['manager_name'];
    scannedAt = json['scanned_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['barcode'] = barcode;
    data['qty'] = qty;
    data['qty_scanned'] = qtyScanned;
    data['manager_name'] = managerName;
    data['scanned_at'] = scannedAt;
    return data;
  }
}