import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../models /product_filter_model.dart';

class HiveService {
  initHive() async {
    final applicationDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(ProductFilterModelAdapter())
      ..registerAdapter(ChildDataAdapter());
    Hive.openBox<List<ProductFilterModel>>('product_filter');
    Hive.openBox<List<ChildDataProduct>>('child_data');
  }
}
