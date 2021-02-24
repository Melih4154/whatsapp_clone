import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/core/services/chat_service.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/viewmodels/chats_model.dart';
import 'package:whatsapp_clone/viewmodels/contacts_model.dart';
import 'package:whatsapp_clone/viewmodels/conversation_model.dart';
import 'package:whatsapp_clone/viewmodels/main_model.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerLazySingleton(() => NavigatorService());

  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => SignInModel());
  getIt.registerFactory(() => ConversationModel());
  getIt.registerFactory(() => MainModel());
  getIt.registerFactory(() => ContactsModel());
}
