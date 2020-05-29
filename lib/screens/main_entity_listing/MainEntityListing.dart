import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/http/web_clients/web_client.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/screens/entity_detailing/EntityDetailing.dart';

final _appBarTitle = "APP_NAME";

class MainEntityListing extends StatelessWidget {
  final httpClient = WebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FutureBuilder<List<MainEntity>>(
          initialData: List<MainEntity>(),
          future: httpClient.getMainEntityList(),
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
                  final List<MainEntity> mainEntityList = asyncSnapshotBuilder.data;
                  if (mainEntityList.isNotEmpty){
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final mainEntity = mainEntityList[index];
                        return MainEntityItem(mainEntity);
                      },
                      itemCount: mainEntityList.length,
                    );
                  }else{
                    return Text("No Entity Found");
                  }
                }else if (asyncSnapshotBuilder.hasError){
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
              Image.network(
                _mainEntity.image_url,
              ),
              Text(_mainEntity.title),
            ],
          ),
        ),
      ),
    ));
  }
}
