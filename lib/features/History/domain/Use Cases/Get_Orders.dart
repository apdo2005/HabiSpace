import 'package:habispace/features/History/domain/Repository/history_repo.dart';
import 'package:habispace/features/History/domain/entities/order_entity.dart';

class GetOrders {
  final HistoryRepo historyRepo;

  GetOrders(this.historyRepo);

  Future<List<OrderEntity>> call() {
    return historyRepo.getHistory();
  }
}
