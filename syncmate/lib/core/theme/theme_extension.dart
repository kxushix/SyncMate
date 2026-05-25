import 'package:flutter/material.dart';
import 'package:syncmate/core/theme/app_colors.dart';

extension ThemeX on BuildContext {
  AppColors get color => Theme.of(this).extension<AppColors>()!;
}
