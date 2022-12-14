import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// ignore: camel_case_types
class dbConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_contact'); //database name
    var database = await openDatabase(path, version: 1, onCreate: _createDb);
    return database;
  }

  Future<void> _createDb(Database database, int version) async {
    String sql =
        "CREATE TABLE contacts (id INTEGER PRIMARY KEY,Name TEXT,ContactNumber Text,info TEXT);";
    await database.execute(sql);
  }
}
