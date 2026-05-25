import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_colors.dart';

/// A reusable menu button with a custom SVG icon and ripple effect.
/// 
/// extracted to a separate widget to follow modularity and reusability principles.
class MenuButton extends StatelessWidget {
  final VoidCallback onTap;
  
  const MenuButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.s4),
        hoverColor: AppColors.rippleColor,
        splashColor: AppColors.rippleColor,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s8),
          child: SvgPicture.asset(
            AppAssets.menuIcon,
            width: 20,
            height: 20,
            // Ensure proper rendering even if asset is missing during dev
            placeholderBuilder: (context) => const SizedBox(
              width: 20, 
              height: 20, 
              child: Icon(Icons.menu, size: 20)
            ),
          ),
        ),
      ),
    );
  }
}
