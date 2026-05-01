import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/features/History/data/history_data_source.dart';
import 'package:habispace/features/History/data/order_model.dart';

class HistoryDataSourceImpl implements HistoryDatasource {
  @override
  Future<List<OrderModel>> getHistory() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.orders);
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data
            .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }
}
