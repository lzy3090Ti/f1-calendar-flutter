import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/calendar/presentation/calendar_page.dart';
import '../features/calendar/presentation/race_detail_page.dart';
import '../features/calendar/domain/race.dart';
import '../features/standings/presentation/standings_page.dart';
import '../features/standings/presentation/team_detail_page.dart';
import 'theme.dart';

final Provider<GoRouter> routerProvider = Provider<GoRouter>(
  (ref) => createRouter(),
);

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/calendar',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/calendar',
                pageBuilder: (context, state) =>
                    _fadePage(const CalendarPage()),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'race/:round',
                    pageBuilder: (context, state) =>
                        _fadePage(RaceDetailPage(race: state.extra! as Race)),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/standings',
                pageBuilder: (context, state) =>
                    _fadePage(const StandingsPage()),
                routes: <RouteBase>[
                  GoRoute(
                    path: 'team/:id',
                    pageBuilder: (context, state) => _fadePage(
                      TeamDetailPage(
                        constructorId: state.pathParameters['id'] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Tab 切换与详情页进入统一用 200ms 淡入，不做位移，保持克制。
CustomTransitionPage<void> _fadePage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 160),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

/// 底部两个 Tab 的外壳：导航栏上方一条 1px 分割线，不用阴影。
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: palette.card,
          border: Border(top: BorderSide(color: palette.divider, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) => navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            ),
            destinations: const <NavigationDestination>[
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: '赛历',
              ),
              NavigationDestination(
                icon: Icon(Icons.leaderboard_outlined),
                selectedIcon: Icon(Icons.leaderboard),
                label: '积分',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
