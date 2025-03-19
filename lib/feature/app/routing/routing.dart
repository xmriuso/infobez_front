import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/feature/app/init_page/init_page.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

import '../../all_courses_page/page/all_courses_page.dart';
import '../../auth_page/page/auth_page.dart';
import '../../detail_course_page/page/detail_course_page.dart';
import '../../favourites_courses_page/page/favourites_courses_page.dart';
import '../../profile_page/page/profile_page.dart';
import 'custom_navigation_bar.dart';

final GlobalKey<NavigatorState> _allCoursesKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _favouritesKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _profileKey = GlobalKey<NavigatorState>();

final List<StatefulShellBranch> _bottomNavBranches = <StatefulShellBranch>[
  StatefulShellBranch(
    navigatorKey: _allCoursesKey,
    restorationScopeId: 'all_courses',
    routes: [
      GoRoute(
          path: RoutePath.allCoursesPage,
          name: RoutePath.allCoursesPage,
          builder: (context, state) => AllCoursesPage(),
          routes: [
            GoRoute(
              path: RoutePath.detailCoursePage,
              name: RoutePath.detailCoursePage,
              builder: (context, state) => DetailCoursePage(),
            ),
          ]),
    ],
  ),
  StatefulShellBranch(
    navigatorKey: _favouritesKey,
    restorationScopeId: 'favourites',
    routes: [
      GoRoute(
        path: RoutePath.favouritesCoursesPage,
        builder: (context, state) => FavouritesCoursesPage(),
      ),
    ],
  ),
  StatefulShellBranch(
    navigatorKey: _profileKey,
    restorationScopeId: 'profile',
    routes: [
      GoRoute(
        path: RoutePath.profilePage,
        builder: (context, state) => ProfilePage(),
      ),
    ],
  ),
];

class RoutesInit {
  factory RoutesInit() {
    return _instance ??= RoutesInit._();
  }

  RoutesInit._();

  static RoutesInit? _instance;
  final GoRouter router = GoRouter(
    initialLocation: RoutePath.init,
    routes: [
      GoRoute(
        path: RoutePath.init,
        builder: (context, state) => InitPage(),
      ),
      GoRoute(
        path: RoutePath.authPage,
        builder: (context, state) => AuthPage(),
      ),
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'shell_route',
        // navigatorContainerBuilder: (context, shell, children) {
        //   return IndexedStack( // ✅ Держим все страницы в памяти
        //     index: shell.currentIndex,
        //     children: children,
        //   );
        // },
        builder: (context, state, child) {
          return CustomNavigationBar(index: child.currentIndex, child: child);
        },
        branches: _bottomNavBranches,
      ),
    ],
  );
}
