import '../entity/message_entity.dart';
import '../chat_repo/chat_repo.dart';

class SendMessageUseCase {
  final ChatRepo repo;
  SendMessageUseCase(this.repo);

  Future<MessageEntity> call(int conversationId, String body) =>
      repo.sendMessage(conversationId, body);
}