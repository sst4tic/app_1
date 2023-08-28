import '../../models /product_filter_model.dart';

class FilterModel {
  FilterModel({
     this.status,
     this.typeOfInvoice,
     this.dateOther,
     this.dateCompleted,
     this.dateReturned,
     this.dateCanceled,
     this.manager,
     this.paymentsMethod,
     this.shipmentType,
     this.discount,
     this.saleChannel,
     this.bill,
     this.servicePoint,
     this.shipmentPoint,
     this.withDocs,
  });
  late final Status? status;
  late final TypeOfInvoice? typeOfInvoice;
  late final Date? dateOther;
  late final DateCompleted? dateCompleted;
  late final DateReturned? dateReturned;
  late final DateCanceled? dateCanceled;
  late final Manager? manager;
  late final PaymentsMethod? paymentsMethod;
  late final ShipmentType? shipmentType;
  late final Discount? discount;
  late final SaleChannel? saleChannel;
  late final Bill? bill;
  late final ServicePoint? servicePoint;
  late final ShipmentPoint? shipmentPoint;
  late final WithDocs? withDocs;

  FilterModel.fromJson(Map<String, dynamic> json){
    status = Status.fromJson(json['status']);
    typeOfInvoice = TypeOfInvoice.fromJson(json['type_of_invoice']);
    dateOther = Date.fromJson(json['date']);
    dateCompleted = DateCompleted.fromJson(json['date_completed']);
    dateReturned = DateReturned.fromJson(json['date_returned']);
    dateCanceled = DateCanceled.fromJson(json['date_canceled']);
    manager = Manager.fromJson(json['manager']);
    paymentsMethod = PaymentsMethod.fromJson(json['payments_method']);
    shipmentType = ShipmentType.fromJson(json['shipment_type']);
    discount = Discount.fromJson(json['discount']);
    saleChannel = SaleChannel.fromJson(json['sale_channel']);
    bill = Bill.fromJson(json['bill']);
    servicePoint = ServicePoint.fromJson(json['service_point']);
    shipmentPoint = ShipmentPoint.fromJson(json['shipment_point']);
    withDocs = WithDocs.fromJson(json['with_docs']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status?.toJson();
    data['type_of_invoice'] = typeOfInvoice?.toJson();
    data['date_other'] = dateOther?.toJson();
    data['date_completed'] = dateCompleted?.toJson();
    data['date_returned'] = dateReturned?.toJson();
    data['date_canceled'] = dateCanceled?.toJson();
    data['manager'] = manager?.toJson();
    data['payments_method'] = paymentsMethod?.toJson();
    data['shipment_type'] = shipmentType?.toJson();
    data['discount'] = discount?.toJson();
    data['sale_channel'] = saleChannel?.toJson();
    data['bill'] = bill?.toJson();
    data['service_point'] = servicePoint?.toJson();
    data['shipment_point'] = shipmentPoint?.toJson();
    data['with_docs'] = withDocs?.toJson();
    return data;
  }
}

class Status {
  Status({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  String? type;
  String? value;
  String? name;
  int? initialValue;
  late final List<ChildData> childData;

  Status.fromJson(Map<String, dynamic> json){
    type = json['type'] ?? '';
    value = json['value'] ?? '';
    name = json['name'] ?? '';
    initialValue = json['initial_value'] ?? 0;
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}

class TypeOfInvoice {
  TypeOfInvoice({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  late final String type;
  late final String value;
  late final String name;
  late final String initialValue;
  late final List<ChildData> childData;

  TypeOfInvoice.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Date {
  Date({
    required this.type,
    required this.name,
    required this.value,
  });
  late final String type;
  late final String name;
  late final String value;

  Date.fromJson(Map<String, dynamic> json){
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class DateCompleted {
  DateCompleted({
    required this.type,
    required this.name,
    required this.value,
  });
  late final String type;
  late final String name;
  late final String value;

  DateCompleted.fromJson(Map<String, dynamic> json){
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class DateReturned {
  DateReturned({
    required this.type,
    required this.name,
    required this.value,
  });
  late final String type;
  late final String name;
  late final String value;

  DateReturned.fromJson(Map<String, dynamic> json){
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class DateCanceled {
  DateCanceled({
    required this.type,
    required this.name,
    required this.value,
  });
  late final String type;
  late final String name;
  late final String value;

  DateCanceled.fromJson(Map<String, dynamic> json){
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class Manager {
  Manager({
    required this.type,
    required this.name,
    required this.value,
  });
  late final String type;
  late final String name;
  late final String value;

  Manager.fromJson(Map<String, dynamic> json){
    type = json['type'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class PaymentsMethod {
  PaymentsMethod({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  PaymentsMethod.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}

class ShipmentType {
  ShipmentType({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  String? type;
  String? value;
  String? name;
  int? initialValue;
  late final List<ChildData> childData;

  ShipmentType.fromJson(Map<String, dynamic> json){
    type = json['type'] ?? '';
    value = json['value'] ?? '';
    name = json['name'] ?? '';
    initialValue = json['initial_value'] ?? 0;
    childData = (json['data'] as List<dynamic>)
        .map((e) => ChildData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e) => e.toJson()).toList();
    return data;
  }
}

class Discount {
  Discount({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  late final String type;
  late final String value;
  late final String name;
  late final String initialValue;
  late final List<ChildData> childData;

  Discount.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}

class SaleChannel {
  SaleChannel({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  String? type;
  String? value;
  String? name;
  int? initialValue;
  late final List<ChildData> childData;

  SaleChannel.fromJson(Map<String, dynamic> json){
    type = json['type'] ?? '';
    value = json['value'] ?? '';
    name = json['name'] ?? '';
    initialValue = json['initial_value'] ?? 0;
    childData = (json['data'] as List<dynamic>)
        .map((e) => ChildData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e) => e.toJson()).toList();
    return data;
  }
}

class Bill {
  Bill({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  Bill.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}

class ServicePoint {
  ServicePoint({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  ServicePoint.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}

class ShipmentPoint {
  ShipmentPoint({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  String? type;
  String? value;
  String? name;
  int? initialValue;
  late final List<ChildData> childData;

  ShipmentPoint.fromJson(Map<String, dynamic> json){
    type = json['type'] ?? '';
    value = json['value'] ?? '';
    name = json['name'] ?? '';
    initialValue = json['initial_value'] ?? 0;
    childData = (json['data'] as List<dynamic>)
        .map((e) => ChildData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e) => e.toJson()).toList();
    return data;
  }
}

class WithDocs {
  WithDocs({
    required this.type,
    required this.value,
    required this.name,
    required this.initialValue,
    required this.childData,
  });
  late final String type;
  late final String value;
  late final String name;
  late final String initialValue;
  late final List<ChildData> childData;

  WithDocs.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['value'] = value;
    data['name'] = name;
    data['initial_value'] = initialValue;
    data['data'] = childData.map((e)=>e.toJson()).toList();
    return data;
  }
}