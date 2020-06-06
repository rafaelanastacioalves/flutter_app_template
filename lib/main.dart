import 'package:flutter/material.dart';
import 'package:flutter_app_template/dependency_injection/app_dependencies.dart';
import 'package:flutter_app_template/repository/database/main_entity_dao.dart';
import 'package:flutter_app_template/repository/http/web_clients/web_client.dart';

import 'screens/main_entity_listing/MainEntityListing.dart';

void main() {
  runApp(AppTemplate(
    dAO: DAO(),
    webClient: WebClient(),
  ));
}
//
class AppTemplate extends StatelessWidget {
  final WebClient webClient;
  final DAO dAO;


  AppTemplate({@required this.dAO, @required this.webClient});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      webClient: webClient,
      dAO: dAO,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainEntityListing(),
      ),
    );
  }


}
