abstract class AbstractMovingScanner {
  Future movingScan({required id, required String barcode});
  Future loadData({required id});
  Future movingScanQty({required id, required String barcode, required int qty});
}