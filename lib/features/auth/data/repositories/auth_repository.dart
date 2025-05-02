import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_app/core/core.dart';
import 'package:pokedex_app/features/auth/data/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<void> registerUser(String username, String password);

  Future<User?> login(String username, String password);

  Future<void> ensureDefaultUser();

  Future<void> saveSession(User user);

  Future<User?> getSavedSession();

  Future<void> clearSession();
}

class AuthRepositoryImpl implements AuthRepository {
  final DatabaseService _databaseService;
  final StoreRef<String, Map<String, dynamic>> _store = stringMapStoreFactory
      .store(DatabaseService.usersStore);
  final StoreRef<String, Map<String, dynamic>> _sessionStore =
      stringMapStoreFactory.store('user_session');

  static const String sessionKey = 'current_user_session';

  AuthRepositoryImpl(this._databaseService);

  @override
  Future<void> registerUser(String username, String password) async {
    try {
      final db = await _databaseService.database;
      final finder = Finder(filter: Filter.equals('username', username));
      final existing = await _store.findFirst(db, finder: finder);
      if (existing != null) {
        throw AuthException('User already exists'.hardcoded);
      }
      final user = User(
        id: const Uuid().v4(),
        username: username,
        password: password,
      );
      await _store.add(db, user.toJson());
    } catch (e) {
      if (e is AppException) rethrow;
      throw DbException('Failed to register user: $e');
    }
  }

  @override
  Future<User?> login(String username, String password) async {
    try {
      final db = await _databaseService.database;
      final finder = Finder(
        filter: Filter.and([
          Filter.equals('username', username),
          Filter.equals('password', password),
        ]),
      );
      final record = await _store.findFirst(db, finder: finder);
      return record == null ? null : User.fromJson(record.value);
    } catch (e) {
      throw DbException('Failed to login: $e');
    }
  }

  @override
  Future<void> ensureDefaultUser() async {
    try {
      final db = await _databaseService.database;
      final count = await _store.count(db);
      if (count == 0) {
        await registerUser('user', 'password');
      }
    } catch (_) {
      try {
        final db = await _databaseService.database;
        await _store.add(db, {
          'id': 'default-id',
          'username': 'user',
          'password': 'password',
        });
      } catch (e2) {
        throw DbException('Failed to create default user: $e2');
      }
    }
  }

  @override
  Future<void> saveSession(User user) async {
    try {
      final db = await _databaseService.database;
      await _sessionStore.record(sessionKey).put(db, user.toJson());
    } catch (e) {
      throw DbException('Failed to save user session: $e');
    }
  }

  @override
  Future<User?> getSavedSession() async {
    try {
      final db = await _databaseService.database;
      final data = await _sessionStore.record(sessionKey).get(db);
      return data == null ? null : User.fromJson(data);
    } catch (e) {
      throw DbException('Failed to get saved session: $e');
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      final db = await _databaseService.database;
      await _sessionStore.record(sessionKey).delete(db);
    } catch (e) {
      throw DbException('Failed to clear user session: $e');
    }
  }

  Future<List<Map<String, dynamic>>> debugListUsers() async {
    final db = await _databaseService.database;
    final snaps = await _store.find(db);
    return snaps.map((s) => s.value).toList();
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(ref.watch(databaseServiceProvider));
}
