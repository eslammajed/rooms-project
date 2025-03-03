import 'dart:io';

import '/modles/itme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHElper {
  Database? _database;
  int Version_db = 1;

  String Table_Name_Reservation = 'Reservations_Tb';
  String id = 'id';
  String Name = 'Name';
  String Type = 'Type';
  String Quantity = 'Quantity';
  String Price = 'Price';
  String Address = 'Address';
  String Images = 'Images';
  String Date = 'Date';
  String Target = 'Target';

  Future<Database?> get CreatDataBase async {
    if (_database != null) {
      return _database;
    } else {
      return _database = await initiolaizDatabase();
    }
  }

  Future<Database> initiolaizDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    return await openDatabase("$path/harveating.db", version: Version_db,
        onCreate: (db, version) async {
      await db.execute('''
  CREATE TABLE $Table_Name_Reservation (
  $id INTEGER PRIMARY KEY AUTOINCREMENT,
  $Name TEXT ,
  $Type TEXT ,
  $Quantity INTEGER,
  $Price REAL ,
  $Address TEXT ,
  $Images TEXT,
  $Date TEXT,
  $Target TEXT
)
''');
    });
  }

  Future<int> InsertTable(itme harvesting) async {
    Database? db = await CreatDataBase;
    String query = '''
    INSERT INTO $Table_Name_Reservation
    ($Name, $Type, $Quantity, $Price, $Address, $Images, $Date, $Target)
    VALUES
    (
      '${harvesting.Name}',
      '${harvesting.Type}',
      '${harvesting.Quantity}',
      '${harvesting.price}',
      '${harvesting.Address}',
     '${harvesting.Images}',
     '${harvesting.Date}',
      '${harvesting.Target}'
    )
  ''';
    return await db!.rawInsert(query);
  }

  Future<int> DeletDataTable(int idH) async {
    final Database? db = await CreatDataBase;
    return await db!.delete(
      Table_Name_Reservation,
      where: "$id=?",
      whereArgs: [idH],
    );
  }

  Future<int> UpdateDataTable(itme harvesting) async {
    final Database? db = await CreatDataBase;
    return await db!.update(
      Table_Name_Reservation,
      harvesting.ToMap(),
      where: "$id=?",
      whereArgs: [harvesting.id],
    );
  }

  Future<void> DeleteALl() async {
    final Database? db = await CreatDataBase;
    return await db!.execute('DELETE FROM Harvesting_Tb;');
  }

  Future<List<itme>> ShowDataTable() async {
    final Database? db = await CreatDataBase;
    final List<Map<String, dynamic>> map =
        await db!.query(Table_Name_Reservation);
    return List.generate(map.length, (i) {
      return itme(
          id: map[i][id],
          Name: map[i][Name],
          Type: map[i][Type],
          Quantity: map[i][Quantity],
          price: map[i][Price],
          Address: map[i][Address],
          Images: map[i][Images],
          Date: map[i][Date],
          Target: map[i][Target]);
    });
  }
}
