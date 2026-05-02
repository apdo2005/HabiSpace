import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';
import 'package:habispace/features/Favorite/Domain/Repositories/Favorite_repository.dart';
import 'package:habispace/features/Favorite/Data/FavoriteRemoteDataSource.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteRemoteDataSource remoteDataSource;

  FavoriteRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PropertyEntity>> getFavorites() async {
    return await remoteDataSource.fetchFavorites();
  }

  @override
  Future<void> removeFavorite(int propertyId) async {
    return await remoteDataSource.removeFavorite(propertyId);
  }
  
  @override
  Future<void> addFavorite(int propertyId) async {
    return await remoteDataSource.addFavorite(propertyId);
  }
   
}  

