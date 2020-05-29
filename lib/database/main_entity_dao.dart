import 'package:flutter_app_template/database/database.dart';
import 'package:flutter_app_template/models/MainEntity.dart';
import 'package:sqflite/sqflite.dart';

class DAO {
  static const main_entitiy_table_name = 'main_entity';
  static const _id = 'id';
  static const _title = 'title';
  static const creationStatement = "CREATE TABLE $main_entitiy_table_name("
      "$_id INTEGER PRIMARY KEY, "
      "$_title TEXT"
      ")";

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
        mainEntityListMap.map((item) => MainEntity.fromJson(item));
    return mainEntityList;
  }
}
