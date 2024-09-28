import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_itmu/features/home/presentation/pages/home_page.dart';
import 'package:mobile_itmu/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:mobile_itmu/framework/core/observer/custom_route_observer.dart';
import 'package:mobile_itmu/service_locator.dart';

part 'app_route.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routerDelegate = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [serviceLocator<CustomRouteObserver>()],
  initialLocation: '/${Routes.home}',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigaion(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${Routes.home}',
              name: Routes.home,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${Routes.product}',
              name: Routes.product,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${Routes.service}',
              name: Routes.service,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${Routes.history}',
              name: Routes.history,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${Routes.account}',
              name: Routes.account,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
      ],
    )
  ],
);
