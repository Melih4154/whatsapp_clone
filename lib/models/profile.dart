import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String id;
  final String userName;
  final String image;

  Profile({this.id, this.userName, this.image});

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
      id: snapshot.id,
      userName: snapshot['userName'],
      image: snapshot['image'],
    );
  }
}
