
import '../repositories/Favorite_repository.dart';

class RemoveFavouriteUseCase {
  final FavoriteRepository repository;

  RemoveFavouriteUseCase(this.repository);

  Future<void> call(int propertyId) async {
    return await repository.removeFavorite(propertyId);
  }
}
