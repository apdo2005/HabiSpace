import 'package:habispace/features/Favorite/Data/PropertyModel.dart';
import 'package:habispace/features/History/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.amount,
    required super.currency,
    required super.status,
    required super.createdAt,
    required super.property,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      amount: json['amount']?.toString() ?? '0',
      currency: json['currency']?.toString() ?? 'usd',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      property: PropertyModel.fromJson(json['property'] as Map<String, dynamic>),
    );
  }
}
