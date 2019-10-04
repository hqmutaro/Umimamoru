import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:umimamoru/infrastructure/service/occurring_manager.dart';

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
    if (!await this.existsBeach(beach)) {
      return await this.db.insert("Watch", {'beach' : beach});
    }
    return 0;
  }

  Future<int> removeBeach(String beach) async{
    var manager = OccurringManager.getInstance();
    if (await manager.isOccurring(beach)) {
      await manager.deleteOccurring(beach);
    }
    return await this.db.rawDelete('DELETE FROM Watch WHERE beach = ?', [beach]);
  }

  Future<bool> existsBeach(String beach) async{
    var watchBeaches = await this.getWatchBeaches();
    print("Watching: " + watchBeaches.toString());
    var result = watchBeaches.where((watch) => watch == beach);
    return result.contains(beach);
  }

  Future<List<String>> getWatchBeaches() async{
    List<String> watches = [];
    var query = await this.db.rawQuery('SELECT * FROM Watch');
    query.forEach((item) => watches.add(item["beach"]));
    return watches;
  }

  // TODO: Singleton以外でアクセスする方法
  static WatchProvider getInstance() => _instance;
}