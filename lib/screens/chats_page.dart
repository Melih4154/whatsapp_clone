import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/screens/chats_detail_page.dart';
import 'package:whatsapp_clone/viewmodels/chats_model.dart';
import 'package:whatsapp_clone/viewmodels/sign_in_model.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ChatsModel>();
    final user = Provider.of<SignInModel>(context).currentUser;

    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: StreamBuilder<List<Conversation>>(
          stream: model.conversation(user.uid),
          builder: (context, AsyncSnapshot<List<Conversation>> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data
                  .map((doc) => ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatsDetailPage(
                                conversation: doc,
                                userId: user.uid,
                              ),
                            ),
                          );
                        },
                        // onTap: () => service.navigateTo(ChatsDetailPage(
                        //   conversation: doc,
                        //   userId: user.uid,
                        // )),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(doc.profileImage),
                        ),
                        title: Text(doc.name),
                        subtitle: Text(doc.displayMessage),
                        trailing: Column(
                          children: [
                            Text(
                              "10:10",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "15",
                                    textScaleFactor: 0.8,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            );
          }),
    );
  }
}
