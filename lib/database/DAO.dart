import 'package:flutter_app_template/database/database.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:sqflite/sqflite.dart';

class DAO {
  Future<int> save(MainEntity mainEntity) async {
    final Database db = await getDatabase();
    Map<String, dynamic> mainEntityMap = _toMap(mainEntity);
    return db.insert('main_entity', mainEntityMap);
  }

  Future<List<MainEntity>> findAll() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> mainEntityListMap =
        await db.query('main_entity');
    List<MainEntity> mainEntityList = _toList(mainEntityListMap);
    return mainEntityList;
  }

  Map<String, dynamic> _toMap(MainEntity mainEntity) {
    var map = Map<String, dynamic>();
    map['title'] = mainEntity.title;
    return map;
  }

  List<MainEntity> _toList(List<Map<String, dynamic>> mainEntityListMap) {
    List<MainEntity> mainEntityList = List<MainEntity>();
    mainEntityListMap.forEach((mapItem) {
      MainEntity mainEntity = MainEntity(id: mapItem['id'],title: mapItem['title']);
      mainEntityList.add(mainEntity);
    });
    return mainEntityList;
  }
}
