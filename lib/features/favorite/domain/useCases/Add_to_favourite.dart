
import '../repositories/Favorite_repository.dart';

class AddToFavouriteUseCase {
  final FavoriteRepository repository;

  AddToFavouriteUseCase(this.repository);

  Future<void> call(int propertyId) async {
    return await repository.addFavorite(propertyId);
  }
}
