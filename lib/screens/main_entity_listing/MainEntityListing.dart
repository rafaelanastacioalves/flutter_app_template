import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/database/MainEntityDAO.dart';
import 'package:flutter_app_template/http/http_client.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:flutter_app_template/screens/entity_detailing/EntityDetailing.dart';

final _appBarTitle = "APP_NAME";

class MainEntityListing extends StatelessWidget {
  final http_client = HttpClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: FutureBuilder<List<MainEntity>>(
        initialData: List<MainEntity>(),
        future: http_client.getMainEntityList(),
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

              }
              break;
          }
          return Text("Unknown Error");
        },
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
