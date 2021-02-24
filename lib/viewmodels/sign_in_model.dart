import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/core/services/auth_service.dart';
import 'package:whatsapp_clone/screens/home_page.dart';
import 'base_model.dart';

class SignInModel extends BaseModel {
  final AuthService _authService = getIt<AuthService>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User get currentUser => _authService.currentUser;

  Future<void> signIn(String userName) async {
    if (userName.isEmpty) {
      return;
    }

    busy = true;

    try {
      var user = await _authService.signIn();

      await _firestore.collection('profile').doc(user.uid).set({
        'userName': userName,
        'image':
            'https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_1280.jpg',
      });

      await navigatorService.navigateToReplace(HomePage());
    } catch (e) {
      busy = false;
    }
    busy = false;
  }
}
