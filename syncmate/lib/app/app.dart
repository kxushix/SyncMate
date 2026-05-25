import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncmate/core/theme/app_theme.dart';
import 'package:syncmate/core/theme/cubit/theme_cubit.dart';
import 'package:syncmate/app/router/app_router.dart';

/// The root widget of the application.
///
/// Uses a [StatefulWidget] to maintain a persistent instance of [AppRouter],
/// ensuring the navigation state is preserved across theme changes.
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Initialize the router once. In a real app, isLoggedIn would be
  // driven by an AuthBloc or AuthRepository.
  late final _appRouter = AppRouter(isLoggedIn: true);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          // Using the instance-based router configuration
          routerConfig: _appRouter.router,
        );
      },
    );
  }
}
