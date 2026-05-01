
import '../chat_repo/chat_repo.dart';
import '../entity/conversation_entity.dart';

class GetConversationUseCase {
  final ChatRepo repo;
  GetConversationUseCase(this.repo);

  Future<ConversationEntity> call(int conversationId) =>
      repo.getConversation(conversationId);
}