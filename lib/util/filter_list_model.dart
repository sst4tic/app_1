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
    final _data = <String, dynamic>{};
    _data['status'] = status?.toJson();
    _data['type_of_invoice'] = typeOfInvoice?.toJson();
    _data['date_other'] = dateOther?.toJson();
    _data['date_completed'] = dateCompleted?.toJson();
    _data['date_returned'] = dateReturned?.toJson();
    _data['date_canceled'] = dateCanceled?.toJson();
    _data['manager'] = manager?.toJson();
    _data['payments_method'] = paymentsMethod?.toJson();
    _data['shipment_type'] = shipmentType?.toJson();
    _data['discount'] = discount?.toJson();
    _data['sale_channel'] = saleChannel?.toJson();
    _data['bill'] = bill?.toJson();
    _data['service_point'] = servicePoint?.toJson();
    _data['shipment_point'] = shipmentPoint?.toJson();
    _data['with_docs'] = withDocs?.toJson();
    return _data;
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
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  Status.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ChildData {
  ChildData({
    required this.value,
    required this.text,
  });
  late final value;
  late final String text;

  ChildData.fromJson(Map<String, dynamic> json){
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['text'] = text;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['name'] = name;
    _data['value'] = value;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['name'] = name;
    _data['value'] = value;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['name'] = name;
    _data['value'] = value;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['name'] = name;
    _data['value'] = value;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['name'] = name;
    _data['value'] = value;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  ShipmentType.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  SaleChannel.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
  late final String type;
  late final String value;
  late final String name;
  late final int initialValue;
  late final List<ChildData> childData;

  ShipmentPoint.fromJson(Map<String, dynamic> json){
    type = json['type'];
    value = json['value'];
    name = json['name'];
    initialValue = json['initial_value'];
    childData = List.from(json['data']).map((e)=>ChildData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['value'] = value;
    _data['name'] = name;
    _data['initial_value'] = initialValue;
    _data['data'] = childData.map((e)=>e.toJson()).toList();
    return _data;
  }
}