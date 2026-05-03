import '../entity/conversation_entity.dart';
import '../entity/message_entity.dart';

abstract class ChatRepo {
  Future<List<ConversationEntity>> getConversations();
  Future<ConversationEntity> getConversation(int conversationId);
  Future<MessageEntity> sendMessage(int conversationId, String body);
  Future<ConversationEntity> startConversation(int agentUserId, int propertyId);
}