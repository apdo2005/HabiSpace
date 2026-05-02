import '../Entities/PropertyEntity.dart';

abstract class FavoriteRepository {
  Future<List<PropertyEntity>> getFavorites();
  Future<void> removeFavorite(int propertyId);
  Future<void> addFavorite(int propertyId);
}
