import 'package:habispace/features/History/data/history_data_source.dart';
import 'package:habispace/features/History/domain/Repository/history_repo.dart';
import 'package:habispace/features/History/domain/entities/order_entity.dart';

class HistoryRepoImpl implements HistoryRepo {
  final HistoryDatasource historyDataSource;

  HistoryRepoImpl({required this.historyDataSource});

  @override
  Future<List<OrderEntity>> getHistory() async {
    return await historyDataSource.getHistory();
  }
}
