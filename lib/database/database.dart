import 'package:flutter_app_template/database/MainEntityDAO.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {


  final _dbName = 'app_name.db';
  final String path = join(await getDatabasesPath(), _dbName);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(DAO.creationStatement);
    },
    version: 1,
  );
}