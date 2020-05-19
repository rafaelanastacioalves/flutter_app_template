import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {

  final _dbName = 'app_name.db';
  final String path = join(await getDatabasesPath(), _dbName);
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute("CREATE IF NOT EXISTS TABLE main_entity("
          "id INTEGER PRIMARY KEY, "
          "title TEXT"
          ")");
    },
    version: 1,
  );
}