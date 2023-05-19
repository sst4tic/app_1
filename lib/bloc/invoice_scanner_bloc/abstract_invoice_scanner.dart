abstract class AbstractInvoiceScanner {
  Future invoiceScan({required id, required String barcode});
  Future loadData({required id});
  Future invoiceScanQty({required id, required String barcode, required int qty});
}