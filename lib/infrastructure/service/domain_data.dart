import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:umimamoru/infrastructure/service/occurring_manager.dart';

class DomainData {

  static DomainData _instance;
  Database db;

  Future<void> init() async {
    _instance = this;
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentDirectory.path, "Domain.db");
    this.db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database newDb, int version) async{
          newDb.execute("""
            CREATE TABLE IF NOT EXISTS Domain
              (
                id INTEGER PRIMARY KEY,
                beach TEXT,
                module TEXT,
                pole TEXT
              )
              """);
        }
    );
    //deleteDatabase(dbPath);
  }

  // Beach
  Future<int> setBeachMap(Map<String, dynamic> map) async{
    if (await this.existsBeach()) {
      return await this.db.update("Domain", {'beach' : json.encode(map)});
    }
    return await this.db.insert("Domain", {'beach' : json.encode(map)});
  }

    Future<Map<String, dynamic>> getBeachMap() async{
      var query = await this.db.query("Domain", columns: ["beach"]);
      var result = json.decode(query.first["beach"]);
      print("Beach: $result");
      return result;
  }

  Future<bool> existsBeach() async{
    var query = await this.db.query("Domain", columns: ["beach"]);
    return query.length >= 1;
  }

  // Module
  Future<int> setModuleMap(Map<String, dynamic> map) async{
    if (await this.existsModule()) {
      return await this.db.update("Domain", {'module' : json.encode(map)});
    }
    return await this.db.insert("Domain", {'module' : json.encode(map)});
  }

  Future<Map<String, dynamic>> getModuleMap() async{
    var query = await this.db.query("Domain", columns: ["module"]);
    var moduleMap = json.decode(query.first["module"]);
    return moduleMap;
  }

  Future<bool> existsModule() async{
    var query = await this.db.query("Domain", columns: ["module"]);
    print("Query: $query");
    return query.length >= 1;
  }

  // Pole
  Future<int> setPoleMap(Map<String, dynamic> map) async{
    if (await this.existsPole()) {
      return await this.db.update("Domain", {'pole' : json.encode(map)});
    }
    return await this.db.insert("Domain", {'pole' : json.encode(map)});
  }

  Future<Map<String, dynamic>> getPoleMap() async{
    var query = await this.db.query("Domain", columns: ["pole"]);
    var result = json.decode(query.first["pole"]);
    return result;
  }

  Future<bool> existsPole() async{
    var query = await this.db.query("Domain", columns: ["pole"]);
    print("Query: $query");
    return query.length >= 1;
  }

  // TODO: Singleton以外でアクセスする方法
  static DomainData getInstance() => _instance;
}