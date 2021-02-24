import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/core/services/navigator_service.dart';
import 'package:whatsapp_clone/screens/home_page.dart';
import 'package:whatsapp_clone/screens/sign_in_page.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  setupLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (BuildContext context, SignInModel model, Widget child) =>
            MaterialApp(
          title: 'Flutter Demo',
          navigatorKey: getIt<NavigatorService>().navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: model.currentUser == null ? SignInPage() : HomePage(),
        ),
      ),
    );
  }
}
