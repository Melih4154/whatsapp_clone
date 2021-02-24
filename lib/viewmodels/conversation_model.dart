import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationModel with ChangeNotifier {
  CollectionReference _ref;

  Stream<QuerySnapshot> getConversation(String userId) {
    _ref =
        FirebaseFirestore.instance.collection('conversation/$userId/messages');
    return _ref.orderBy('time').snapshots();
  }

  Future<void> messagesAdd(Map<String, dynamic> data) async {
    await _ref.add(data);
  }
}
