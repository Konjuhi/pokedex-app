import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/models/user.dart';
import '../data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<User?> build() async {
    await ref.read(authRepositoryProvider).ensureDefaultUser();

    final savedUser = await ref.read(authRepositoryProvider).getSavedSession();
    if (savedUser != null) {
      return savedUser;
    }

    return null;
  }

  Future<bool> login(String username, String password) async {
    state = const AsyncValue.loading();

    try {
      final user = await ref
          .read(authRepositoryProvider)
          .login(username, password);

      if (user != null) {
        await ref.read(authRepositoryProvider).saveSession(user);
        state = AsyncValue.data(user);
        return true;
      } else {
        state = const AsyncValue.data(null);
        return false;
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await ref.read(authRepositoryProvider).clearSession();
      state = const AsyncValue.data(null);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool get isLoggedIn => state.valueOrNull != null;
}
