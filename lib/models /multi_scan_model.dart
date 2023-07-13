class MultiScanModel {
  MultiScanModel({
    required this.invoiceId,
    required this.barcode,
    required this.qty,
    required this.qtyScanned,
  });
  late final int invoiceId;
  late final String barcode;
   int qty = 1;
   int qtyScanned = 0;

  MultiScanModel.fromJson(Map<String, dynamic> json){
    invoiceId = json['invoice_id'];
    barcode = json['barcode'];
    qty = json['qty'];
    qtyScanned = json['qty_scanned'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['barcode'] = barcode;
    data['qty'] = qty;
    data['qty_scanned'] = qtyScanned;
    return data;
  }
}