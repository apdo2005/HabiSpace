import '../entities/favorite_property_entity.dart';

abstract class FavoriteRepository {
  Future<List<FavoritePropertyEntity>> getFavorites();
  Future<void> addFavorite(int propertyId);
  Future<void> removeFavorite(int propertyId);
}
