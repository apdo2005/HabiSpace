import '../../domain/entity/conversation_entity.dart';
import 'message_model.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.propertyId,
    required super.buyerId,
    required super.agentId,
    required super.messages,
    required super.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json['id'] ?? 0,
    propertyId: json['property_id'] ?? 0,
    buyerId: json['buyer_id'] ?? json['user_id'] ?? 0,
    agentId: json['agent_id'] ?? 0,
    messages: (json['messages'] as List? ?? [])
        .map((m) => MessageModel.fromJson(m as Map<String, dynamic>))
        .toList(),
    createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
  );
}