import 'package:flutter/material.dart';

/// Centralized color palette for the application.
/// 
/// Using a class with static constants to avoid magic color codes
/// across the codebase and ensure theme consistency.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFE5E7EB);
  static const Color white = Colors.white;
  
  /// Used for the coin pill and language dropdown borders
  static const Color border = Color(0xFFECECEC);
  
  /// Subtle border for dropdown/pills
  static Color borderSubtle = Colors.grey.withOpacity(0.3);

  static const Color blackText = Color(0xFF000000);
  static const Color greyText = Color(0xFF757575);
  
  /// Primary text color for the app
  static const Color textPrimary = Color(0xFF1A1A1A);
  
  /// Ripple effect color for hit areas
  static Color rippleColor = Colors.black.withOpacity(0.05);

  // Navigation Colors
  static const Color navIconActive = Color(0xFF000000);
  static const Color navIconInactive = Color(0xFF9E9E9E);
}

