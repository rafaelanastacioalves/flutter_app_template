import 'package:flutter/material.dart';
import 'package:flutter_app_template/models/MainEntity.dart';

class EntityDetaling extends StatelessWidget {
  final MainEntity _mainEntity;

  EntityDetaling(this._mainEntity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mainEntity.title),
      ),
    );
  }
}
