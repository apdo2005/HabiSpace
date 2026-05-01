class PropertyEntity {
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
  final String type; // e.g. "For a Rent", "For Sale"
  final List<String> amenities;
  final String distance;

  PropertyEntity({
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
