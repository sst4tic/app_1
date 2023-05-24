class SalesDetailsModel {
  SalesDetailsModel({
    required this.client,
    required this.manager,
    required this.printUrl,
    this.btnAct,
    required this.btnText,
    this.products,
    required this.details,
    required this.shipment,
    required this.totalPrice,
    required this.boxesPermission,
    this.boxesQty,
    required this.status,
  });
  late final Client client;
  late final Manager manager;
  late final String printUrl;
  late final String? btnAct;
  late final String btnText;
  late final List<Products>? products;
  late final Details details;
  late final Shipment shipment;
  late final String totalPrice;
  late final bool boxesPermission;
  late final int? boxesQty;
  late final int status;
  late final bool btnSheet;
  late final bool btnChronology;
  late final bool btnBan;
  late final bool btnPrint;
  late final bool btnScan;
  late final bool btnBoxes;


  SalesDetailsModel.fromJson(Map<String, dynamic> json){
    client = Client.fromJson(json['client']);
    manager = Manager.fromJson(json['manager']);
    printUrl = json['print_url'];
    btnAct = json['btnAct'];
    btnText = json['btnText'] ?? '';
    products = json['products'] != null ? List.from(json['products']).map((e)=>Products.fromJson(e)).toList() : null;
    details = Details.fromJson(json['details']);
    shipment = Shipment.fromJson(json['shipment']);
    totalPrice = json['totalPrice'];
    boxesPermission = json['btnBoxesAdd'];
    boxesQty = json['boxes_qty'];
    status = json['status'];
    btnSheet = json['btnSheet'];
    btnChronology = json['btnChronology'];
    btnBan = json['btnBan'];
    btnPrint = json['btnPrint'];
    btnScan = json['btnScanProduct'];
    btnBoxes = json['btnScanBoxes'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['client'] = client.toJson();
    data['manager'] = manager.toJson();
    data['print_url'] = printUrl;
    data['btnAct'] = btnAct;
    data['btnText'] = btnText;
    data['products'] = products?.map((e)=>e.toJson()).toList();
    data['details'] = details.toJson();
    data['shipment'] = shipment.toJson();
    data['totalPrice'] = totalPrice;
    data['btnBoxesAdd'] = boxesPermission;
    data['boxes_qty'] = boxesQty;
    data['status'] = status;
    data['btnSheet'] = btnSheet;
    data['btnChronology'] = btnChronology;
    data['btnBan'] = btnBan;
    data['btnScanProduct'] = btnScan;
    data['btnScanBoxes'] = btnBoxes;
    return data;
  }
}

class Client {
  Client({
    this.name,
  });
  String? name;

  Client.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class Manager {
  Manager({
    this.name,
    this.photo,
    this.role,
  });
  late final String? name;
  late final String? photo;
  late final String? role;

  Manager.fromJson(Map<String, dynamic> json){
    name = json['name'];
    photo = json['photo'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['photo'] = photo;
    data['role'] = role;
    return data;
  }
}

class Products {
  Products({
    required this.id,
    required this.name,
    required this.discount,
    required this.price,
    required this.qty,
  });
  late final  id;
  late final String name;
  late final  discount;
  late final String price;
  late final qty;

  Products.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    discount = json['discount'] ?? 0;
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['discount'] = discount;
    data['price'] = price;
    data['qty'] = qty;
    return data;
  }
}

class Details {
  Details({
    required this.discountName,
    required this.paymentsMethodName,
    required this.servicePoint,
    required this.saleChannelName,
    required this.prepayment,
    required this.withDocs,
  });
  late final String discountName;
  late final String paymentsMethodName;
  late final String servicePoint;
  late final String saleChannelName;
  late final String prepayment;
  late final String withDocs;

  Details.fromJson(Map<String, dynamic> json){
    discountName = json['discountName'];
    paymentsMethodName = json['paymentsMethodName'];
    servicePoint = json['servicePoint'];
    saleChannelName = json['saleChannelName'];
    prepayment = json['prepayment'];
    withDocs = json['withDocs'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['discountName'] = discountName;
    data['paymentsMethodName'] = paymentsMethodName;
    data['servicePoint'] = servicePoint;
    data['saleChannelName'] = saleChannelName;
    data['prepayment'] = prepayment;
    data['withDocs'] = withDocs;
    return data;
  }
}

class Shipment {
  Shipment({
    required this.shipmentPoint,
    required this.shipmentType,
    required this.address,
    this.date,
    required this.urgency,
  });
  late final String shipmentPoint;
  late final String shipmentType;
  late final String address;
  late final String? date;
  late final String urgency;

  Shipment.fromJson(Map<String, dynamic> json){
    shipmentPoint = json['shipmentPoint'];
    shipmentType = json['shipmentType'];
    address = json['address'];
    date = json['date'];
    urgency = json['urgency'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shipmentPoint'] = shipmentPoint;
    data['shipmentType'] = shipmentType;
    data['address'] = address;
    data['date'] = date;
    data['urgency'] = urgency;
    return data;
  }
}