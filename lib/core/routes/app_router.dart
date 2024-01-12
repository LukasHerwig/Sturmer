import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sturmer/features/favorites/screens/favorites_screen.dart';
import 'package:sturmer/features/home/screens/home.dart';
import 'package:sturmer/features/leagues/screens/leagues.dart';
import 'package:sturmer/features/main_layout/main_layout.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey(debugLabel: 'root');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                  name: 'home',
                  path: '/home',
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const HomeScreen(),
                    );
                  })
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  name: 'leagues',
                  path: '/leagues',
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const LeaguesScreen(),
                    );
                  })
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  name: 'favorite',
                  path: '/favorite',
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      child: const FavoritesScreen(),
                    );
                  })
            ],
          ),
        ],
      ),
    ],
  );
});
