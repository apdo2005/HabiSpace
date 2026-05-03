
class FavoritePropertyEntity {
  final int id;
  final String title;
  final String price;
  final String address;
  final int? categoryId;
  final String categoryName;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final double rating;
  final String type;
  final List<String> amenities;
  final String distance;

  FavoritePropertyEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.address,
    required this.categoryId,
    required this.categoryName,
    required this.images,
    required this.bedrooms,
    required this.bathrooms,
    this.rating = 0.0,
    this.type = 'For a Rent',
    this.amenities = const [],
    this.distance = '',
  });
}
