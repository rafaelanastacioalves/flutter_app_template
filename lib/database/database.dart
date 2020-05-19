import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'app_name.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute("CREATE TABLE main_entity("
          "id INTEGER PRIMARY KEY, "
          "title TEXT"
          ")");
    },
    version: 1,
  );
}