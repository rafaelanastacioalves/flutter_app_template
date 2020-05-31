import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class DAO {
  static const main_entitiy_table_name = 'main_entity';
  static const _id = 'id';
  static const _title = 'title';
  static const _imageUrl = 'image_url';
  static const creationStatement = "CREATE TABLE $main_entitiy_table_name("
      "$_id TEXT PRIMARY KEY, "
      "$_title TEXT, "
      "$_imageUrl TEXT"
      ")";

  Future<int> saveAll(List<MainEntity> mainEntityList) async {
    final Database db = await getDatabase();
    mainEntityList.forEach((element) async {await save(element);});
}

  Future<int> save(MainEntity mainEntity) async {
    final Database db = await getDatabase();
    Map<String, dynamic> mainEntityMap = mainEntity.toJson();
    return db.insert(main_entitiy_table_name, mainEntityMap);
  }

  Future<List<MainEntity>> findAll() async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> mainEntityListMap =
        await db.query(main_entitiy_table_name);
    List<MainEntity> mainEntityList =
        mainEntityListMap.map((item) => MainEntity.fromJson(item)).toList();

    if (mainEntityList.length > 0) {
      return mainEntityList;
    }else{
      return null;
    }
  }
}
