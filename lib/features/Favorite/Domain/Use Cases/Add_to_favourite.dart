import '../Repositories/Favorite_repository.dart';

class AddToFavouriteUseCase {
  final FavoriteRepository repository;

  AddToFavouriteUseCase(this.repository);
  Future<void>execute(int propertyId)async{
    return await repository.addFavorite(propertyId);
  }
}
