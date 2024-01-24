import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sturmer/core/navigation/drawer.dart';
import 'package:sturmer/features/favorites/screens/favorites_screen.dart';
import 'package:sturmer/features/home/screens/home.dart';
import 'package:sturmer/features/leagues/screens/details.dart';
import 'package:sturmer/features/leagues/screens/leagues.dart';
import 'package:sturmer/features/main_layout/main_layout.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey();

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainLayout(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                  // parentNavigatorKey: _shellNavigator,
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
                  },
                  routes: [
                    GoRoute(
                        name: 'leaguesDetails',
                        path: 'details/:leagueId/:leagueName',
                        pageBuilder: (context, state) {
                          final leagueIdStr = state.pathParameters['leagueId'];
                          final leagueName = state.pathParameters['leagueName'];

                          final leagueId = int.tryParse(leagueIdStr ?? '0');
                          return MaterialPage(
                            key: state.pageKey,
                            child: LeagueDetailsScreen(
                                leagueId: leagueId, leagueName: leagueName),
                          );
                        })
                  ]),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  // parentNavigatorKey: _shellNavigator,
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
