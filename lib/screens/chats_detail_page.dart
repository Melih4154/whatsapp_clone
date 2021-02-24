import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/viewmodels/conversation_model.dart';

class ChatsDetailPage extends StatefulWidget {
  final String userId;
  final Conversation conversation;

  const ChatsDetailPage({Key key, this.userId, this.conversation})
      : super(key: key);
  @override
  _ChatsDetailPageState createState() => _ChatsDetailPageState();
}

class _ChatsDetailPageState extends State<ChatsDetailPage> {
  TextEditingController _controller = TextEditingController();
  final ConversationModel model = getIt<ConversationModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: InkWell(
              child: Icon(Icons.videocam),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: InkWell(
              child: Icon(Icons.phone),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: InkWell(
              child: Icon(Icons.more_vert_outlined),
            ),
          ),
        ],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.conversation.profileImage),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(widget.conversation.name),
          ],
        ),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/12/03/08/50/paper-1074131_1280.jpg"))),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: model.getConversation(widget.conversation.id),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                      children: snapshot.data.docs
                          .map(
                            (document) => ListTile(
                              title: Align(
                                alignment: widget.userId == document['senderId']
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      document['message'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.tag_faces,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _controller,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(15.0),
                                  border: InputBorder.none,
                                  hintText: "Mesaj yaz!",
                                ),
                                onFieldSubmitted: (value) async {
                                  setState(() {
                                    value = _controller.text;
                                  });
                                  await model.messagesAdd({
                                    'senderId': widget.userId,
                                    'message': value,
                                    'time': DateTime.now(),
                                  });
                                  _controller.clear();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  child: Icon(
                                Icons.attach_file_sharp,
                                color: Colors.grey,
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor),
                    child: Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
