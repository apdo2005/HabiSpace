import '../entity/property_entity.dart';
import '../home_repo/home_repo.dart';

class SearchPropertiesUseCase {
  final HomeRepo repo;
  SearchPropertiesUseCase(this.repo);

  Future<List<PropertyEntity>> call(String query) =>
      repo.searchProperties(query);
}