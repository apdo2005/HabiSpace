import '../../domain/entity/filter_entity.dart';
import '../models/home_model.dart';
import '../models/property_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHome();
  Future<List<PropertyModel>> searchProperties(String query);
  Future<List<PropertyModel>> filterProperties(FilterEntity filter);
}
