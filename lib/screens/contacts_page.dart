import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/models/profile.dart';
import 'package:whatsapp_clone/viewmodels/contacts_model.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rehber"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: ContactSearchDelegate());
              }),
          IconButton(icon: Icon(Icons.more_vert), onPressed: null),
        ],
      ),
      body: ContactList(),
    );
  }
}

class ContactList extends StatelessWidget {
  final String query;

  const ContactList({Key key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();

    return FutureBuilder<List<Profile>>(
        future: model.filterProfiles(query),
        builder: (context, AsyncSnapshot<List<Profile>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data.length == 0) {
            return Center(
              child: Text("Kayıtlı Numara Yok."),
            );
          }

          return ListView(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.group_add),
                ),
                title: Text("Yeni Grup"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person_add),
                ),
                title: Text("Yeni Kişi Ekle"),
              ),
            ]..addAll(
                snapshot.data
                    .map(
                      (profile) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profile.image),
                        ),
                        title: Text(profile.userName),
                        onTap: () async => model.startConversation(profile),
                      ),
                    )
                    .toList(),
              ),
          );
        });
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }
}
