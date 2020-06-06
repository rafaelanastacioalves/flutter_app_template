import 'package:flutter/material.dart';
import 'package:flutter_app_template/dependency_injection/app_dependencies.dart';
import 'package:flutter_app_template/models/EntityDetails.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/models/Resource.dart';
import 'package:flutter_app_template/repository/Repository.dart';
import 'package:flutter_app_template/repository/http/web_clients/web_client.dart';
import 'package:flutter_app_template/screens/main_entity_listing/MainEntityListing.dart';

class EntityDetaling extends StatelessWidget {
  EntityDetaling(this._mainEntity);

  final MainEntity _mainEntity;


  @override
  Widget build(BuildContext context) {
    var repository = AppDependencies.of(context).appRepository;
    return Scaffold(
      appBar: AppBar(
        title: Text(_mainEntity.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<Resource<EntityDetails>>(
          future: repository.getEntityDetails(_mainEntity.id),
          builder: (buildContext, asyncSnapshot) {
            switch (asyncSnapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return LoadingScreen();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (asyncSnapshot.hasData) {
                  final Resource<EntityDetails> resource = asyncSnapshot.data;
              switch (resource.status) {

                case Status.SUCCESS:
                  return EntityDetaisScreen(resource.data);
                  break;
                case Status.INTERNAL_SERVER_ERROR:
                  return Text(resource.message);
                  break;
                case Status.GENERIC_ERROR:
                  return Text(resource.message);
                  break;
                case Status.LOADING:
                  return Text(resource.message);
                  break;
              };
                } else if (asyncSnapshot.hasError) {
                  return Text(asyncSnapshot.error.toString());
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