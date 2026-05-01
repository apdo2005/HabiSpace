import '../../domain/entity/filter_entity.dart';
import '../../domain/entity/home_entity.dart';
import '../../domain/entity/property_entity.dart';
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
  Future<List<PropertyEntity>> searchProperties(String query) async {
    return await remoteDataSource.searchProperties(query);
  }

  @override
  Future<List<PropertyEntity>> filterProperties(FilterEntity filter) async {
    final result = await remoteDataSource.filterProperties(filter);
    return result;
  }
}