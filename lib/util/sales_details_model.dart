import 'package:yiwucloud/util/product.dart';

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
    this.contacts,
    required this.boxesPermission,
    this.boxesQty,
    required this.status,
    required this.statusName,
    this.assemblerName,
    this.courierName,
    required this.isPostponed,
    required this.btnPostpone,
    this.country,
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
  late final List<String>? contacts;
  late final bool boxesPermission;
  late final int? boxesQty;
  late final int status;
  late final String statusName;
  late final String? assemblerName;
  late final String? courierName;
  late final bool btnSheet;
  late final bool btnChronology;
  late final bool btnBan;
  late final bool btnPrint;
  late final bool btnScan;
  late final bool btnBoxes;
  late final bool isPostponed;
  late final bool btnPostpone;
  late final String? country;

  SalesDetailsModel.fromJson(Map<String, dynamic> json) {
    client = Client.fromJson(json['client']);
    manager = Manager.fromJson(json['manager']);
    printUrl = json['print_url'];
    btnAct = json['btnAct'];
    btnText = json['btnText'] ?? '';
    products = json['products'] != null
        ? List.from(json['products']).map((e) => Products.fromJson(e)).toList()
        : null;
    details = Details.fromJson(json['details']);
    shipment = Shipment.fromJson(json['shipment']);
    totalPrice = json['totalPrice'];
    contacts = json['contacts'] != null ? List.from(json['contacts']) : null;
    boxesPermission = json['btnBoxesAdd'];
    boxesQty = json['boxes_qty'];
    status = json['status'];
    statusName = json['status_name'];
    assemblerName = json['assembler_name'];
    courierName = json['courier_name'];
    btnSheet = json['btnSheet'];
    btnChronology = json['btnChronology'];
    btnBan = json['btnBan'];
    btnPrint = json['btnPrint'];
    btnScan = json['btnScanProduct'];
    btnBoxes = json['btnScanBoxes'];
    isPostponed = json['isPostponed'];
    btnPostpone = json['btnPostponed'];
    country = json['countryAndCity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['client'] = client.toJson();
    data['manager'] = manager.toJson();
    data['print_url'] = printUrl;
    data['btnAct'] = btnAct;
    data['btnText'] = btnText;
    data['products'] = products?.map((e) => e.toJson()).toList();
    data['details'] = details.toJson();
    data['shipment'] = shipment.toJson();
    data['totalPrice'] = totalPrice;
    data['contacts'] = contacts;
    data['btnBoxesAdd'] = boxesPermission;
    data['boxes_qty'] = boxesQty;
    data['status'] = status;
    data['status_name'] = statusName;
    data['assembler_name'] = assemblerName;
    data['courier_name'] = courierName;
    data['btnSheet'] = btnSheet;
    data['btnChronology'] = btnChronology;
    data['btnBan'] = btnBan;
    data['btnScanProduct'] = btnScan;
    data['btnScanBoxes'] = btnBoxes;
    data['isPostponed'] = isPostponed;
    data['btnPostponed'] = btnPostpone;
    data['countryAndCity'] = country;
    return data;
  }
}

class Client {
  Client({
    this.name,
    this.phone,
  });

  String? name;
  String? phone;

  Client.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
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

  Manager.fromJson(Map<String, dynamic> json) {
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
    this.availability,
  });

  late final id;
  late final String name;
  late final discount;
  late final String price;
  late final qty;
  late final List<Availability>? availability;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    discount = json['discount'] ?? 0;
    price = json['price'];
    qty = json['qty'];
    availability = json['availability'] != null
        ? List.from(json['availability'])
        .map((e) => Availability.fromJson(e))
        .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['discount'] = discount;
    data['price'] = price;
    data['qty'] = qty;
    data['availability'] = availability?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Details {
  Details({
    required this.discountName,
    required this.paymentsMethodName,
    this.servicePoint,
    required this.saleChannelName,
    required this.prepayment,
    required this.withDocs,
    this.kaspiNum
  });

  late final discountName;
  late final String paymentsMethodName;
  late final String? servicePoint;
  late final String saleChannelName;
  late final String prepayment;
  late final String withDocs;
  late final String? kaspiNum;

  Details.fromJson(Map<String, dynamic> json) {
    discountName = json['discountName'];
    paymentsMethodName = json['paymentsMethodName'];
    servicePoint = json['servicePoint'];
    saleChannelName = json['saleChannelName'];
    prepayment = json['prepayment'];
    withDocs = json['withDocs'];
    kaspiNum = json['kaspi_num'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['discountName'] = discountName;
    data['paymentsMethodName'] = paymentsMethodName;
    data['servicePoint'] = servicePoint;
    data['saleChannelName'] = saleChannelName;
    data['prepayment'] = prepayment;
    data['withDocs'] = withDocs;
    data['kaspi_num'] = kaspiNum;
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

  Shipment.fromJson(Map<String, dynamic> json) {
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
