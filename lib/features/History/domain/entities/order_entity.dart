
import '../../../favorite/domain/entities/favorite_property_entity.dart';

class OrderEntity {
  final int id;
  final String amount;
  final String currency;
  final String status;
  final String createdAt;
  final FavoritePropertyEntity property;

  OrderEntity({
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.property,
  });
}
