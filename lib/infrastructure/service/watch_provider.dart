import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class WatchProvider {

  static WatchProvider _instance;
  Database db;

  Future<void> init() async {
    _instance = this;
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDirectory.path, "Watch.db");
    this.db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database newDb, int version) async{
          newDb.execute("""
            CREATE TABLE IF NOT EXISTS Watch
              (
                id INTEGER PRIMARY KEY,
                beach TEXT
              )
              """);
        }
    );
    //deleteDatabase(dbPath);
  }

  Future<int> addBeach(String beach) async{
    return await this.db.insert("Watch", {'beach' : beach});
  }

  Future<int> removeBeach(String beach) async{
    return await this.db.delete("Watch", where: "beach = $beach");
  }

  Future<List<String>> getWatchBeaches() async{
    List<String> watches = [];
    var query = await this.db.query("Watch", where: "beach");
    query.forEach((item) => watches.add(item["beach"]));
    return watches;
  }

  // TODO: Singleton以外でアクセスする方法
  static WatchProvider getInstance() => _instance;
}