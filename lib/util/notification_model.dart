class NotificationClass {
  NotificationClass({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.invoiceData,
    required this.unread,
  });
  late final int id;
  late final String title;
  late final String body;
  late final String date;
  late final InvoiceData? invoiceData;
  late final bool unread;

  NotificationClass.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    body = json['body'];
    date = json['date'];
    invoiceData = InvoiceData.fromJson(json['invoice_data']);
    unread = json['unread'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['date'] = date;
    data['invoice_data'] = invoiceData!.toJson();
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