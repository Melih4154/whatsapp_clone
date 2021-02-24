import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return ChangeNotifierProvider(
      create: (BuildContext context) => getIt<SignInModel>(),
      child: Consumer<SignInModel>(
        builder: (context, SignInModel model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Giriş Yap.'),
          ),
          body: Container(
            padding: EdgeInsets.all(8.0),
            child: model.busy
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("UserName"),
                      TextField(
                        controller: _controller,
                      ),
                      RaisedButton(
                        onPressed: () async =>
                            await model.signIn(_controller.text),
                        child: Text("Giriş Yap"),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
