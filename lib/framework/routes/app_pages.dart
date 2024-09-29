import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_itmu/features/auth/login/presentation/pages/login_page.dart';
import 'package:mobile_itmu/features/home/presentation/pages/home_page.dart';
import 'package:mobile_itmu/features/home/presentation/widgets/bottom_navigation.dart';
import 'package:mobile_itmu/framework/core/observer/custom_route_observer.dart';
import 'package:mobile_itmu/framework/managers/helper.dart';
import 'package:mobile_itmu/framework/managers/secure_storage_config/secure_storage_db_service.dart';
import 'package:mobile_itmu/service_locator.dart';

part 'app_route.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final routerDelegate = GoRouter(
  navigatorKey: _rootNavigatorKey,
  observers: [serviceLocator<CustomRouteObserver>()],
  initialLocation: '/${Routes.login}',
  redirect: _guard,
  routes: [
    GoRoute(
      path: '/${Routes.login}',
      name: Routes.login,
      builder: (context, state) => const LoginPage(),
    ),
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
    ),
  ],
);

FutureOr<String?> _guard(BuildContext context, GoRouterState state) async {
  final isLoggedIn = await SecureStorageDbService().checkUserLoggedIn();
  final bool signingIn = state.matchedLocation.startsWith('/login');
  printError(isLoggedIn);
  // Jika user sudah login, jangan biarkan dia mengakses halaman login
  if (isLoggedIn && signingIn) {
    return '/home'; // Arahkan ke halaman home jika sudah login
  }
  // Jika user tidak login, arahkan ke halaman login
  if (!isLoggedIn) {
    return '/login';
  }
  return null;
}
