import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainEntityListing(),
    );
  }
}

class MainEntityListing extends StatefulWidget {
  final List<MainEntity> mainEntityList = [
    MainEntity("Number 1"),
    MainEntity("Number 2")
  ];

  @override
  State<StatefulWidget> createState() {
    return MainEntityListingState();
  }
}

class MainEntityListingState extends State<MainEntityListing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APP_NAME"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final mainEntity = widget.mainEntityList[index];
          return MainEntityItem(mainEntity);
        },
        itemCount: widget.mainEntityList.length,
      ),
    );
  }
}

class MainEntityItem extends StatelessWidget {
  final MainEntity _mainEntity;

  MainEntityItem(this._mainEntity);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(_mainEntity.title),
    );
  }
}

class MainEntity {
  final String title;

  MainEntity(this.title);
}
