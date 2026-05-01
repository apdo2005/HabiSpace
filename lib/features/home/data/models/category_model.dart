import '../../domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.description,
    required super.sortOrder,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    description: json['description'],
    sortOrder: json['sort_order'],
  );
}