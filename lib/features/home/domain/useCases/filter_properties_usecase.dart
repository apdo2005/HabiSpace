
import '../entities/filter_entity.dart';
import '../entities/home_property_entity.dart';
import '../home_repo/home_repo.dart';

class FilterPropertiesUseCase {
  final HomeRepo repo;
  FilterPropertiesUseCase(this.repo);

  Future<List<HomePropertyEntity>> call(FilterEntity filter) =>
      repo.filterProperties(filter);
}