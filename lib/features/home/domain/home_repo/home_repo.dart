import '../entity/filter_entity.dart';
import '../entity/home_entity.dart';
import '../entity/property_entity.dart';

abstract class HomeRepo {
  Future<HomeEntity> getHome();
  Future<List<PropertyEntity>> searchProperties(String query);
  Future<List<PropertyEntity>> filterProperties(FilterEntity filter);


}