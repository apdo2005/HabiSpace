import 'agent_entity.dart';
import 'category_entity.dart';

class PropertyEntity {
  final int id;
  final String title;
  final String slug;
  final String description;
  final double price;
  final String listingType; // "sale" or "rent"
  final String status;
  final int bedrooms;
  final int bathrooms;
  final int kitchens;
  final bool isFeatured;
  final int salesCount;
  final double latitude;
  final double longitude;
  final String address;
  final CategoryEntity category;
  final List<String> images;
  final AgentEntity agent;

  PropertyEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.price,
    required this.listingType,
    required this.status,
    required this.bedrooms,
    required this.bathrooms,
    required this.kitchens,
    required this.isFeatured,
    required this.salesCount,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.category,
    required this.images,
    required this.agent,
  });
}