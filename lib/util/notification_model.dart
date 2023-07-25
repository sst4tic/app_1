class NotificationClass {
  NotificationClass({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.invoiceData,
    this.movingData,
    required this.unread,
  });
  late final int id;
  late final String title;
  late final String body;
  late final String date;
  late final InvoiceData? invoiceData;
  late final MovingData? movingData;
  late final bool unread;

  NotificationClass.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    body = json['body'];
    date = json['date'];
    invoiceData = json['invoice_data'] != null ? InvoiceData.fromJson(json['invoice_data']) : null;
    movingData = json['moving_data'] != null ? MovingData.fromJson(json['moving_data']) : null;
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['date'] = date;
    data['invoice_data'] = invoiceData;
    data['moving_data'] = movingData;
    data['unread'] = unread;
    return data;
  }
}

class InvoiceData {
  InvoiceData({
    required this.invoiceId,
    required this.id,
  });
  late final String invoiceId;
  late final int id;

  InvoiceData.fromJson(Map<String, dynamic> json){
    invoiceId = json['invoice_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['invoice_id'] = invoiceId;
    data['id'] = id;
    return data;
  }
}

class MovingData {
  MovingData({
    required this.movingId,
    required this.id,
  });
  late final String movingId;
  late final int id;

  MovingData.fromJson(Map<String, dynamic> json){
    movingId = json['moving_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['moving_id'] = movingId;
    data['id'] = id;
    return data;
  }
}