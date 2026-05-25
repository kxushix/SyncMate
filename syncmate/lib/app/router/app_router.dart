import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncmate/app/router/route_gaurd.dart';
import 'package:syncmate/app/router/routes_name.dart';
import 'package:syncmate/app/router/routes_path.dart';
// import 'package:syncmate/features/home/presentation/screens/home_screen.dart';
import 'package:syncmate/features/explore/presentation/screens/explore_screen.dart';
import 'package:syncmate/features/submit/presentation/screens/submit_screen.dart';
import 'package:syncmate/features/library/presentation/screens/library_screen.dart';
import 'package:syncmate/features/profile/presentation/screens/profile_screen.dart';
import 'package:syncmate/shared/widgets/custom_bottom_nav_bar.dart';

/// A robust, scalable navigation system that merges existing auth guards
/// with the production-quality StatefulShellRoute architecture.
class AppRouter {
  final bool isLoggedIn;

  AppRouter({required this.isLoggedIn});

  // Navigator keys for persistence and deep linking support
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'home',
  );
  static final _exploreNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'explore',
  );
  static final _submitNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'submit',
  );
  static final _libraryNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'library',
  );
  static final _profileNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: 'profile',
  );

  late final GoRouter router = GoRouter(
    initialLocation: RoutesPath.home,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,

    // Integrating existing Auth Guard logic
    redirect: (context, state) {
      return RouteGaurd.authGaurd(isLoggedIn, state.matchedLocation);
    },

    routes: [
      // ShellRoute handles the persistent Bottom Navigation Bar across different tabs
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationWrapper(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              // GoRoute(
              //   name: RoutesName.home,
              //   path: RoutesPath.home,
              //   pageBuilder: (context, state) => const NoTransitionPage(
              //     child: HomeScreen(),
              //   ),
              // ),
            ],
          ),
          // Branch 2: Explore
          StatefulShellBranch(
            navigatorKey: _exploreNavigatorKey,
            routes: [
              GoRoute(
                name: RoutesName.explore,
                path: RoutesPath.explore,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ExploreScreen()),
              ),
            ],
          ),
          // Branch 3: Submit (Floating Center Button)
          StatefulShellBranch(
            navigatorKey: _submitNavigatorKey,
            routes: [
              GoRoute(
                name: RoutesName.submit,
                path: RoutesPath.submit,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: SubmitScreen()),
              ),
            ],
          ),
          // Branch 4: Library
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                name: RoutesName.library,
                path: RoutesPath.library,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: LibraryScreen()),
              ),
            ],
          ),
          // Branch 5: Profile
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                name: RoutesName.profile,
                path: RoutesPath.profile,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
