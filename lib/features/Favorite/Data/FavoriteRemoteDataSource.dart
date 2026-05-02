import 'package:habispace/features/Favorite/Data/PropertyModel.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<PropertyModel>> fetchFavorites();
  Future<void> removeFavorite(int propertyId);
  Future<void> addFavorite(int propertyId);
}
