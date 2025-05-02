import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

import 'package:pokedex_app/core/database/database_service.dart';
import 'package:pokedex_app/features/auth/data/repositories/auth_repository.dart';


class InMemoryDatabaseService implements DatabaseService {
  final DatabaseFactory _factory = databaseFactoryMemory;
  Database? _db;

  @override
  Future<Database> get database async {
    _db ??= await _factory.openDatabase('test.db');
    return _db!;
  }

  @override
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}

void main() {
  late InMemoryDatabaseService dbService;
  late AuthRepositoryImpl repo;

  setUp(() {
    dbService = InMemoryDatabaseService();
    repo = AuthRepositoryImpl(dbService);
  });

  tearDown(() async {
    await dbService.close();
  });

  test('ensureDefaultUser creates default user once', () async {
    await repo.ensureDefaultUser();

    final list1 = await repo.debugListUsers();
    if (kDebugMode) {
      print('After first ensureDefaultUser: $list1');
    }
    expect(await repo.login('user', 'password'), isNotNull);

    await repo.ensureDefaultUser();
    final list2 = await repo.debugListUsers();
    if (kDebugMode) {
      print('After second ensureDefaultUser: $list2');
    }

    final count = list2.where((m) => m['username'] == 'user').length;
    expect(count, equals(1));
  });

}
