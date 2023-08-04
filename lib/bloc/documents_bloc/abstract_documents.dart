

import '../../models /product_filter_model.dart';

abstract class AbstractDocuments {
  Future<ProductFilterModel> getType();
  Future<List<dynamic>> getDocuments({required String type, required int page});
}

class DocumentModel {
  DocumentModel({
    required this.link,
    required this.name,
  });

  late final String link;
  late final String name;

  DocumentModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['link'] = link;
    data['name'] = name;
    return data;
  }
}