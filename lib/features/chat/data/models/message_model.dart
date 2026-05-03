import '../../domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.body,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['id'] ?? 0,
    conversationId: json['conversation_id'] ?? 0,
    senderId: json['sender_id'] ?? json['user_id'] ?? 0,
    body: json['body'] ?? json['message'] ?? '',
    createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
  );
}