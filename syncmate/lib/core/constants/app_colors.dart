import 'package:flutter/material.dart';

/// Centralized color palette for the application.
///
/// All values extracted from the html reference design (`hindi.html`).
/// Using a class with static constants to avoid magic color codes
/// across the codebase and ensure theme consistency.
class AppColors {
  AppColors._();

  /// Primary app background — warm parchment (`#f5f4f0`)
  static const Color background = Color(0xFFF5F4F0);

  static const Color white = Colors.white;

  /// Used for the coin pill and language dropdown borders
  static const Color border = Color(0xFFECECEC);

  /// Subtle border for dropdown/pills
  static const Color borderSubtle = Color(0x4D6E6E6E); // hsla(0,0%,43%,.3)

  static const Color blackText = Color(0xFF000000);
  static const Color greyText = Color(0xFF757575);

  /// Primary text color — near-black ink (`#1a1614`)
  static const Color textPrimary = Color(0xFF1A1614);

  /// Alias matching HTML `color: #1a1614`
  static const Color textInk = Color(0xFF1A1614);

  /// Solid dark background for quote card action bar (`#050505`)
  static const Color actionBarBg = Color(0xFF050505);

  /// Gray for category card border (`#8b8b8b`)
  static const Color categoryCardBorder = Color(0xFF8B8B8B);

  /// Dark badge background for category count (`#171717`)
  static const Color categoryBadgeBg = Color(0xFF171717);

  /// Dark badge border for category count (`#2f2f2f`)
  static const Color categoryBadgeBorder = Color(0xFF2F2F2F);

  /// Light text for category badge (`#f4f4f4`)
  static const Color categoryBadgeText = Color(0xFFF4F4F4);

  /// Ripple effect color for hit areas
  static const Color rippleColor = Color(0x0D000000); // black @ 5%

  // Navigation Colors
  static const Color navIconActive = Color(0xFF1C1C1C);
  static const Color navIconInactive = Color(0xFF9E9E9E);

  // Bottom nav bar
  static const Color navBarBg = Color(0xFFFFFFFF);
}
