import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:whatsapp_clone/screens/chats_detail_page.dart';
import 'base_model.dart';

class ContactsModel extends BaseModel {
  final ChatService _chatService = getIt<ChatService>();
  final AuthService _authService = getIt<AuthService>();

  Future<List<Profile>> filterProfiles(String filter) async {
    return (await _chatService.getContacts())
        .where((element) => element.userName.startsWith(filter ?? ""))
        .toList();
  }

  Future<void> startConversation(Profile profile) async {
    var conversation =
        await _chatService.startConversation(_authService.currentUser, profile);

    navigatorService.navigateTo(ChatsDetailPage(
      userId: _authService.currentUser.uid, //model.currentUser.uid,
      conversation: conversation,
    ));
  }
}
