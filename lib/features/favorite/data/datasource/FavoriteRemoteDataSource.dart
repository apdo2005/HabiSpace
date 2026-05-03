import 'package:habispace/core/constants/api_constant.dart';
import 'package:habispace/core/constants/dio_helper.dart';

import '../models/favorite_property_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<FavoritePropertyModel>> fetchFavorites();
  Future<void> addFavorite(int propertyId);
  Future<void> removeFavorite(int propertyId);
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  const FavoriteRemoteDataSourceImpl();

  @override
  Future<List<FavoritePropertyModel>> fetchFavorites() async {
    try {
      final response = await DioHelper.get(path: ApiConstant.favorite);
      if (response.statusCode == 200) {
        final List data = response.data['data'] as List? ?? [];
        return data.map((json) => FavoritePropertyModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorites: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  @override
  Future<void> addFavorite(int propertyId) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstant.favorite,
        data: {'property_id': propertyId},
      );
      if (response.statusCode != 200 &&
          response.statusCode != 201 &&
          response.statusCode != 204) {
        throw Exception('Failed to add favorite: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding favorite: $e');
    }
  }

  @override
  Future<void> removeFavorite(int propertyId) async {
    try {
      final response = await DioHelper.delete(
        path: '${ApiConstant.favorite}/$propertyId',
      );
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to remove favorite: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error removing favorite: $e');
    }
  }
}
