import 'package:dio/dio.dart';
import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/dio_helper.dart';
import 'package:habispace/features/Favorite/Data/PropertyModel.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<PropertyModel>> fetchFavorites();
  Future<void> removeFavorite(int propertyId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final Dio dio;

  FavoriteRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PropertyModel>> fetchFavorites() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.favorite);
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => PropertyModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Future<void> removeFavorite(int propertyId) async {
    try {
      final response = await DioHelper.delete(
        path: '${ApiConstant.favorite}/$propertyId',
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to remove favorite');
      }
    } catch (e) {
      throw Exception('Error removing favorite: $e');
    }
  }
   
}
