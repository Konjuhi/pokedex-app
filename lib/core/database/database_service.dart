import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';

part 'database_service.g.dart';

class DatabaseService {
  static const String _dbName = 'pokedex.db';

  static const String usersStore = 'users';
  static const String pokemonStore = 'pokemon';
  static const String searchCacheStore = 'search_cache';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    try {
      _database = await _openDatabase();
      return _database!;
    } catch (e) {
      _database = await databaseFactoryMemory.openDatabase(_dbName);
      final store = stringMapStoreFactory.store(usersStore);
      await store.add(_database!, {
        'id': 'default-id',
        'username': 'user',
        'password': 'password',
      });

      return _database!;
    }
  }

  Future<Database> _openDatabase() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocDir.path, _dbName);

      final db = await databaseFactoryIo.openDatabase(dbPath);

      return db;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

@riverpod
DatabaseService databaseService(Ref ref) {
  final service = DatabaseService();
  ref.onDispose(() async {
    await service.close();
  });
  return service;
}
