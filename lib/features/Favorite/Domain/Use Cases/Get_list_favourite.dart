import '../Entities/PropertyEntity.dart';
import '../Repositories/Favorite_repository.dart';

class GetListFavoriteUseCase {
  final FavoriteRepository repository;

  GetListFavoriteUseCase(this.repository);

  Future<List<PropertyEntity>> call() async {
    return await repository.getFavorites();
  }
}
