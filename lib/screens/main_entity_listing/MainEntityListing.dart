import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/models/Resource.dart';
import 'package:flutter_app_template/repository/Repository.dart';
import 'package:flutter_app_template/screens/entity_detailing/EntityDetailing.dart';

final _appBarTitle = "APP_NAME";

class MainEntityListing extends StatelessWidget {
  final appRepository = AppRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<Resource<List<MainEntity>>>(
          future: appRepository.getMainEntityList(),
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
                  final Resource<List<MainEntity>> resource =
                      asyncSnapshot.data;
                  switch (resource.status) {
                    case Status.SUCCESS:
                      if (resource.data.isNotEmpty) {
                        final mainEntityList = resource.data;
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final mainEntity = mainEntityList[index];
                            return MainEntityItem(mainEntity);
                          },
                          itemCount: mainEntityList.length,
                        );
                      }
                      break;
                    case Status.INTERNAL_SERVER_ERROR:
                      return Text(resource.message);
                      break;
                    case Status.GENERIC_ERROR:
                      return Text(resource.message.toString());
                      break;
                    case Status.LOADING:
                      return Text(resource.message);
                      break;
                  }
                  ;
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

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator(), Text('Carregando')],
      ),
    );
  }
}

class MainEntityItem extends StatelessWidget {
  final MainEntity _mainEntity;

  MainEntityItem(this._mainEntity);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EntityDetaling(_mainEntity);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Container(
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: _mainEntity.image_url
              ),
              Text(_mainEntity.title),
            ],
          ),
        ),
      ),
    ));
  }
}
