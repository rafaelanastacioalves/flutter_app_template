import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/screens/entity_detailing/EntityDetailing.dart';

final _appBarTitle = "APP_NAME";

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
        title: Text(_appBarTitle),
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
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EntityDetaling(_mainEntity);
        }));
      },
      title: Text(_mainEntity.title),
      leading: Icon(Icons.pages),
    );
  }
}
