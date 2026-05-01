import 'package:habispace/core/constants/api_constant.dart';

import '../../../../core/constants/dio_helper.dart';
import '../../domain/entity/filter_entity.dart';
import '../models/home_model.dart';
import '../models/property_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHome();
  Future<List<PropertyModel>> searchProperties(String query);
  Future<List<PropertyModel>> filterProperties(FilterEntity filter);

}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HomeModel> getHome() async {
    final response = await DioHelper.get(path: ApiConstant.home);
    return HomeModel.fromJson(response.data);
  }

  @override
  Future<List<PropertyModel>> searchProperties(String query) async {
    final response = await DioHelper.get(
      path: ApiConstant.properties,
      query: {
        'search': query,
        'page': 1,
        'per_page': 15,
      },
    );
    final data = response.data['data'];

    List list;
    if (data is Map && data['data'] is List) {
      list = data['data'] as List;
    } else if (data is List) {
      list = data;
    } else {
      list = [];
    }

    return list.map((e) => PropertyModel.fromJson(e)).toList();
  }

  Future<List<PropertyModel>> filterProperties(FilterEntity filter) async {
    final queryParams = <String, dynamic>{};

    if (filter.listingType != null) queryParams['listing_type'] = filter.listingType;
    if (filter.radiusKm != null)    queryParams['radius_km']    = filter.radiusKm.toString();
    if (filter.latitude != null)    queryParams['latitude']     = filter.latitude.toString();
    if (filter.longitude != null)   queryParams['longitude']    = filter.longitude.toString();

    final response = await DioHelper.get(
      path: ApiConstant.properties,
      query: queryParams,
    );
    final data = response.data['data']
        ?? response.data['properties']
        ?? response.data;

    return (data as List)
        .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }


}