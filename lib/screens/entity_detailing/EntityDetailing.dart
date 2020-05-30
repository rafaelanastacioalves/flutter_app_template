import 'package:flutter/material.dart';
import 'package:flutter_app_template/http/web_clients/web_client.dart';
import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/screens/main_entity_listing/MainEntityListing.dart';

class EntityDetaling extends StatelessWidget {
  EntityDetaling(this._mainEntity);

  final MainEntity _mainEntity;

  final httpClient = WebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mainEntity.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<EntityDetails>(
          future: httpClient.getEntityDetail(_mainEntity.id),
          builder: (buildContext, asyncSnapshotBuilder) {
            switch (asyncSnapshotBuilder.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return LoadingScreen();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (asyncSnapshotBuilder.hasData) {
                  final EntityDetails entityDetails = asyncSnapshotBuilder.data;
                  return EntityDetaisScreen(entityDetails);
                } else if (asyncSnapshotBuilder.hasError) {
                  return Text(asyncSnapshotBuilder.error.toString());
                }
                break;
            }
            return Text("Unknown Error");
          },
        ),
      ),

    );
  }
}

class EntityDetaisScreen extends StatelessWidget {
  final EntityDetails _entityDetails;

  EntityDetaisScreen(this._entityDetails);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.network(
                    _entityDetails.image_url,
                  ),
                  Text(_entityDetails.title),
                ],
              ),
            ),
          ),
        ));
  }
}