import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class OccurringManager {

  static OccurringManager _instance;
  Database db;

  Future<void> init() async {
    _instance = this;
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDirectory.path, "Occuring.db");
    this.db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database newDb, int version) async{
          newDb.execute("""
            CREATE TABLE IF NOT EXISTS Occurring
              (
                id INTEGER PRIMARY KEY,
                beach TEXT
              )
              """);
        }
    );
    //deleteDatabase(dbPath);
  }

  Future<int> setOccurring(String beach) async{
    return await this.db.insert("Occurring", {"beach" : beach});
  }

  Future<int> deleteOccurring(String beach) async{
    return await this.db.delete("Occurring", where: "beach = $beach");
  }

  Future<bool> isOccurring(String beach) async{
    var queryResult = await db.rawQuery('SELECT * FROM Occurring WHERE beach=$beach');
    return queryResult.isNotEmpty;
  }

  Future<List<Map>> getOccurring(String beach) async{
    return await this.db.query("Occurring", where: "beach = $beach");
  }

  Future<List<String>> getOccurringList() async{
    List<String> watches = [];
    var query = await this.db.query("Occurring", where: "beach");
    query.forEach((item) => watches.add(item["beach"]));
    return watches;
  }

  // TODO: Singleton以外でアクセスする方法
  static OccurringManager getInstance() => _instance;
}