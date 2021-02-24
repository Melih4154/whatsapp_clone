import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp_clone/core/locator.dart';
import 'package:whatsapp_clone/screens/chats_page.dart';
import 'package:whatsapp_clone/viewmodels/main_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<MainModel>();

    double width = MediaQuery.of(context).size.width;
    double yourWidth = width / 5;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  title: Text("Whatsapp"),
                  actions: [Icon(Icons.search), Icon(Icons.more_vert)],
                )
              ];
            },
            body: Column(
              children: [
                TabBar(
                  labelStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  indicatorColor: Colors.white,
                  isScrollable: true,
                  controller: _controller,
                  tabs: <Widget>[
                    Container(
                      width: 30,
                      height: 50,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.camera_alt,
                      ),
                    ),
                    Container(
                        width: yourWidth,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("SOHBET")),
                    Container(
                        width: yourWidth,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("DURUM")),
                    Container(
                        width: yourWidth,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text("ARAMALAR"))
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey[100],
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Icon(Icons.directions_car),
                        ChatsPage(),
                        Icon(Icons.directions_transit),
                        Icon(Icons.directions_transit),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await model.navigateToContacts(),
        child: Icon(Icons.message),
      ),
    );
  }
}
