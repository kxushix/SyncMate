import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncmate/app/app.dart';
import 'package:syncmate/core/di/service_locator.dart';
import 'package:syncmate/core/theme/cubit/theme_cubit.dart';

Future<Widget> bootstrap() async {
  await setupDI();

  final themeCubit = getIt<ThemeCubit>()..loadTheme();

  return BlocProvider(create: (_) => themeCubit, child: const App());
}
