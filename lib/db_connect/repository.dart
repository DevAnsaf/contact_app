import 'package:contact_app/db_connect/database_connect.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late dbConnection _dbConnection;

  Repository() {
    _dbConnection = dbConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _dbConnection.setDatabase();
      return _database;
    }
  }

  //Insert Contacts
  insertData(contacts, data) async {
    var connection = await database;
    return await connection?.insert(contacts, data);
  }

  //Read All Record
  readData(contacts) async {
    var connection = await database;
    return await connection?.query(contacts);
  }

  //Read a Single Record By ID
  readDataById(contacts, itemId) async {
    var connection = await database;
    return await connection
        ?.query(contacts, where: 'id=?', whereArgs: [itemId]);
  }

  //Update User
  updateData(contacts, data) async {
    var connection = await database;
    return await connection
        ?.update(contacts, data, where: 'id=?', whereArgs: [data['id']]);
  }

  //Delete Contacts
  deleteDataById(contacts, itemId) async {
    var connection = await database;
    return await connection
        ?.rawDelete("delete from $contacts where id=$itemId");
  }
}
