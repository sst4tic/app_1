import 'package:yiwucloud/models%20/product_filter_model.dart';

class MovingDetailsModel {
  MovingDetailsModel({
    this.invoiceId,
    required this.excelUrl,
    required this.pdfUrl,
    required this.btnBan,
    required this.btnBanAct,
    required this.btnChronology,
    required this.btnBoxes,
    this.btnBoxesSelectStatus,
    this.boxesWait,
    this.boxesSent,
    this.boxesRecd,
    required this.statusName,
    required this.statusId,
    this.btnText,
    this.btnAct,
    this.comments,
    required this.warehouseFromData,
    required this.warehouseToData,
    required this.senderData,
    required this.type,
    required this.createdAt,
    required this.courierName,
    required this.couriers,
    required this.products,
  });

  late final String? invoiceId;
  late final String excelUrl;
  late final String pdfUrl;
  late final bool btnBan;
  late final String btnBanAct;
  late final bool btnChronology;
  late final bool btnBoxes;
  late final BtnBoxesSelectStatus? btnBoxesSelectStatus;
  int? boxesWait;
  int? boxesSent;
  int? boxesRecd;
  late final String statusName;
  late final int statusId;
  late final String? btnText;
  late final String? btnAct;
  late final String? comments;
  late final String warehouseFromData;
  late final String warehouseToData;
  late final String senderData;
  late final String type;
  late final String createdAt;
  late final String? courierName;
  late final Couriers? couriers;
  late final List<Products> products;

  MovingDetailsModel.fromJson(Map<String, dynamic> json) {
    invoiceId = null;
    excelUrl = json['excel_url'];
    pdfUrl = json['pdf_url'];
    btnBan = json['btnBan'];
    btnBanAct = json['btnBanAct'];
    btnChronology = json['btnChronology'];
    btnBoxes = json['btnBoxes'];
    btnBoxesSelectStatus = json['btnBoxesSelectStatus'] != null
        ? BtnBoxesSelectStatus.fromJson(json['btnBoxesSelectStatus'])
        : null;
    boxesWait = json['boxesWait'];
    boxesSent = json['boxesSent'];
    boxesRecd = json['boxesRecd'];
    statusName = json['status_name'];
    statusId = json['status_id'];
    btnText = json['btnText'];
    btnAct = json['btnAct'];
    comments = json['comments'];
    warehouseFromData = json['warehouseFromData'];
    warehouseToData = json['warehouseToData'];
    senderData = json['senderData'];
    type = json['type'];
    createdAt = json['created_at'];
    courierName = json['courierName'];
    couriers =
        json['couriers'] != null ? Couriers.fromJson(json['couriers']) : null;
    products = List.from(json['products'] ?? [])
        .map((e) => Products.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['excel_url'] = excelUrl;
    data['pdf_url'] = pdfUrl;
    data['btnBan'] = btnBan;
    data['btnBanAct'] = btnBanAct;
    data['btnChronology'] = btnChronology;
    data['btnBoxes'] = btnBoxes;
    data['btnBoxesSelectStatus'] =
        btnBoxesSelectStatus != null ? btnBoxesSelectStatus!.toJson() : null;
    data['boxesWait'] = boxesWait;
    data['boxesSent'] = boxesSent;
    data['boxesRecd'] = boxesRecd;
    data['status_name'] = statusName;
    data['status_id'] = statusId;
    data['btnText'] = btnText;
    data['btnAct'] = btnAct;
    data['comments'] = comments;
    data['warehouseFromData'] = warehouseFromData;
    data['warehouseToData'] = warehouseToData;
    data['senderData'] = senderData;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['courierName'] = courierName;
    data['couriers'] = couriers?.toJson();
    data['products'] = products.map((e) => e.toJson()).toList();
    return data;
  }
}

class Products {
  Products({
    required this.name,
    required this.qty,
  });

  late final String name;
  late final int qty;

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['qty'] = qty;
    return data;
  }
}

class BtnBoxesSelectStatus {
  BtnBoxesSelectStatus({
    required this.initialValue,
    required this.data,
  });

  int initialValue = 0;
  late final List<ChildData> data;

  BtnBoxesSelectStatus.fromJson(Map<String, dynamic> json) {
    initialValue = json['initial_value'];
    data = List.from(json['data']).map((e) => ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['initial_value'] = initialValue;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Couriers {
  Couriers({
    required this.initialValue,
    required this.data,
  });

  late final int initialValue;
  late final List<ChildData> data;

  Couriers.fromJson(Map<String, dynamic> json) {
    initialValue = json['initial_value'];
    data = List.from(json['data']).map((e) => ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['initial_value'] = initialValue;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}
