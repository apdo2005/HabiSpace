import '../../domain/entities/home_property_entity.dart';
import 'agent_model.dart';
import 'category_model.dart';

class HomePropertyModel extends HomePropertyEntity {
  HomePropertyModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.price,
    required super.listingType,
    required super.status,
    required super.bedrooms,
    required super.bathrooms,
    required super.kitchens,
    required super.isFeatured,
    required super.salesCount,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.category,
    required super.images,
    required super.agent,
  });

  factory HomePropertyModel.fromJson(Map<String, dynamic> json) => HomePropertyModel(
    id: json['id'],
    title: json['title'],
    slug: json['slug'],
    description: json['description'],
    price: double.parse(json['price'].toString()),
    listingType: json['listing_type'],
    status: json['status'],
    bedrooms: json['bedrooms'],
    bathrooms: json['bathrooms'],
    kitchens: json['kitchens'],
    isFeatured: json['is_featured'],
    salesCount: json['sales_count'],
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    address: json['address'],
    category: CategoryModel.fromJson(json['category']),
    images: (json['images'] as List)
        .map((e) => e['url'] as String)
        .toList(),
    agent: AgentModel.fromJson(json['agent']),
  );
}