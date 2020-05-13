import 'package:flutter/material.dart';

import 'screens/main_entity_listing/MainEntityListing.dart';

void main() => runApp(AppTemplate());

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
