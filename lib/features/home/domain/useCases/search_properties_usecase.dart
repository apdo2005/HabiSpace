import '../entities/home_property_entity.dart';
import '../home_repo/home_repo.dart';

class SearchPropertiesUseCase {
  final HomeRepo repo;
  SearchPropertiesUseCase(this.repo);

  Future<List<HomePropertyEntity>> call(String query) =>
      repo.searchProperties(query);
}