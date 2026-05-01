
import '../entity/filter_entity.dart';
import '../entity/property_entity.dart';
import '../home_repo/home_repo.dart';

class FilterPropertiesUseCase {
  final HomeRepo repo;
  FilterPropertiesUseCase(this.repo);

  Future<List<PropertyEntity>> call(FilterEntity filter) =>
      repo.filterProperties(filter);
}