import 'package:habispace/features/History/data/order_model.dart';

abstract class HistoryDatasource {
  Future<List<OrderModel>> getHistory();
}
