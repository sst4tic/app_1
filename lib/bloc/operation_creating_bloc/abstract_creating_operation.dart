import 'package:yiwucloud/models%20/articles_list_model.dart';
import 'package:yiwucloud/models%20/product_filter_model.dart';

abstract class AbstractCreatingOperation {
  Future<List<ChildData>>getBillsList();
  Future<List<ArticlesListModel>>getArticlesList();
  Future<List<ChildData>>getOperationTypes();
  Future submitMoving({required billsIdTo, required billsIdFrom, required total, comments});
  Future submitAddition({required billsId, required type, required total, required articleId, required invoiceId, comments});
}