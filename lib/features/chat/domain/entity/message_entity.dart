class MessageEntity {
  final int id;
  final int conversationId;
  final int senderId;
  final String body;
  final DateTime createdAt;

  MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.body,
    required this.createdAt,
  });
}