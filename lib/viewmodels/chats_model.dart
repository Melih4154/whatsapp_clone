import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'base_model.dart';

class ChatsModel extends BaseModel {
  final _chatService = GetIt.instance<ChatService>();
  Stream<List<Conversation>> conversation(String userId) {
    return _chatService.getConversations(userId);
  }
}
