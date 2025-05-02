import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex_app/core/theme/tokens_provider.dart';
import 'package:pokedex_app/features/auth/domain/auth_controller.dart';
import 'package:pokedex_app/features/auth/presentation/screens/login_screen.dart';
import 'package:pokedex_app/features/pokemon/presentation/screens/pokedex_screen.dart';
import 'package:pokedex_app/features/pokemon/presentation/screens/search_screen.dart';
import 'package:pokedex_app/features/pokemon/presentation/screens/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'app_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authControllerProvider);
  
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      if (authState.isLoading) {
        return '/splash';
      }
      
      final isLoggedIn = authState.valueOrNull != null;
      final isLoginRoute = state.uri.path == '/login';
      final isSplashRoute = state.uri.path == '/splash';

      if (isSplashRoute) {
        return isLoggedIn ? '/search' : '/login';
      }

      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }

      if (isLoggedIn && isLoginRoute) {
        return '/search';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/pokedex',
                builder: (context, state) => const PokedexScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: context.colors.primary,
        unselectedItemColor: context.colors.textSecondary,
        showUnselectedLabels: true,
        selectedLabelStyle: context.textStyles.labelLarge,
        unselectedLabelStyle: context.textStyles.labelLarge,
        currentIndex: navigationShell.currentIndex,
        onTap: (i) => navigationShell.goBranch(i),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: context.colors.surface,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokédex',
            backgroundColor: context.colors.surface,
          ),
        ],
      ),

    );
  }
} 