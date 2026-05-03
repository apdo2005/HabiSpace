import '../../domain/entities/filter_entity.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/entities/home_property_entity.dart';
import '../../domain/home_repo/home_repo.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);

  @override
  Future<HomeEntity> getHome() async {
    return await remoteDataSource.getHome();
  }

  @override
  Future<List<HomePropertyEntity>> searchProperties(String query) async {
    return await remoteDataSource.searchProperties(query);
  }

  @override
  Future<List<HomePropertyEntity>> filterProperties(FilterEntity filter) async {
    final result = await remoteDataSource.filterProperties(filter);
    return result;
  }
}