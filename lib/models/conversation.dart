import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/models/profile.dart';

class Conversation {
  final String id;
  final String name;
  final String profileImage;
  final String displayMessage;

  Conversation({this.id, this.name, this.profileImage, this.displayMessage});

  factory Conversation.fromSnapshot(DocumentSnapshot snapshot, Profile user) {
    return Conversation(
      id: snapshot.id,
      name: user.userName,
      profileImage: user.image,
      displayMessage: snapshot.data()['displayMessage'],
    );
  }
}
