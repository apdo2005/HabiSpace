import 'package:habispace/features/home/domain/entity/property_entity.dart';

import 'category_entity.dart';

class HomeEntity {
  final List<CategoryEntity> categories;
  final List<PropertyEntity> bestSelling;
  final List<PropertyEntity> featured;
  final List<PropertyEntity> recommended;

  HomeEntity({
    required this.categories,
    required this.bestSelling,
    required this.featured,
    required this.recommended,
  });
}