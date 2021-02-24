import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_clone/models/conversation.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:rxdart/rxdart.dart';

class ChatService {
  final _firebase = FirebaseFirestore.instance;
  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firebase
        .collection('conversations')
        .where('members', arrayContains: userId);

    var profileStream = getContacts().asStream();

    var conversationStream = ref.snapshots();

    return Rx.combineLatest2(
        conversationStream,
        profileStream,
        (QuerySnapshot conversationSnapshot, List<Profile> profiles) =>
            conversationSnapshot.docs.map((snapshot) {
              List<String> members = List.from(snapshot.data()['members']);

              var otherUser = profiles.firstWhere(
                (profile) =>
                    profile.id ==
                    members.firstWhere(
                      (member) => member != userId,
                    ),
              );
              return Conversation.fromSnapshot(snapshot, otherUser);
            }).toList());

    // return ref.snapshots().map((list) => list.docs
    //     .map((snapshot) => Conversation.fromSnapshot(snapshot))
    //     .toList());
  }

  Future<List<Profile>> getContacts() async {
    var ref = _firebase.collection('profile').orderBy('userName');

    var profiles = await ref.get();

    return profiles.docs
        .map((profile) => Profile.fromSnapshot(profile))
        .toList();
  }

  Future<Conversation> startConversation(User user, Profile profile) async {
    var ref = _firebase.collection('conversations');

    var docRef = await ref.add({
      'displayMessage': "",
      'members': [user.uid, profile.id]
    });

    return Conversation(
        id: docRef.id,
        name: profile.userName,
        profileImage: profile.image,
        displayMessage: "");
  }

  Future<Conversation> getConversation(
      String conversationId, String memberId) async {
    var profileSnapshot =
        await _firebase.collection('profile').doc(memberId).get();
    var profile = Profile.fromSnapshot(profileSnapshot);
    return Conversation(
      id: conversationId,
      name: profile.userName,
      profileImage: profile.image,
      displayMessage: "",
    );
  }
}
