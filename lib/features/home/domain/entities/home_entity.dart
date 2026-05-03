
import 'category_entity.dart';
import 'home_property_entity.dart';

class HomeEntity {
  final List<CategoryEntity> categories;
  final List<HomePropertyEntity> bestSelling;
  final List<HomePropertyEntity> featured;
  final List<HomePropertyEntity> recommended;

  HomeEntity({
    required this.categories,
    required this.bestSelling,
    required this.featured,
    required this.recommended,
  });
}