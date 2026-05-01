import 'package:habispace/features/History/domain/entities/order_entity.dart';

abstract class HistoryRepo {
  Future<List<OrderEntity>> getHistory();
}
