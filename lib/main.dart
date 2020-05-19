import 'package:flutter/material.dart';

import 'database/DAO.dart';
import 'models/MainEntity.dart';
import 'screens/main_entity_listing/MainEntityListing.dart';

void main() {
  final DAO dao = DAO();
  runApp(AppTemplate());
  dao.save(MainEntity(title: "Number1"));
  dao.save(MainEntity(title: "Number2"));
}
//
class AppTemplate extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainEntityListing(),
    );
  }
}
