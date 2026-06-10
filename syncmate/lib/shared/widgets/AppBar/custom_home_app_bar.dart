import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import 'coin_pill.dart';
import 'language_dropdown_chip.dart';
import 'menu_button.dart';

/// A production-quality custom App Bar for the Home Screen.
/// 
/// ARCHITECTURE DECISIONS:
/// 1. **Stack-based Alignment**: We use a [Stack] instead of a [Row] for the primary layout. 
///    In a [Row], [MainAxisAlignment.spaceBetween] would push the center section off-center 
///    if the left and right widgets have unequal widths. A [Stack] with [Alignment.center] 
///    guarantees the logo remains mathematically centered relative to the screen width.
/// 2. **PreferredSizeWidget**: Implementing this interface allows the widget to be used 
///    seamlessly in the `appBar` property of a [Scaffold].
/// 3. **SafeArea Integration**: Ensures the app bar respects notch and status bar areas 
///    across different device geometries.
/// 4. **Modular Components**: Menu, Language Dropdown, and Coin Pill are extracted into 
///    reusable widgets to improve maintainability and readability.
class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0, // HTML: px-6 (24px)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --- LEFT SECTION ---
              // Aligned independently to the left.
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2.0), // HTML: margin-bottom: 2px
                  child: MenuButton(
                    onTap: () {
                      // TODO: Open Drawer or Grid Menu
                    },
                  ),
                ),
              ),

              // --- CENTER SECTION ---
              // This section remains perfectly centered regardless of side widget widths.
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0), // HTML: margin-bottom: 10px
                    child: SvgPicture.asset(
                      AppAssets.poetisticLogo,
                      width: 90,
                      height: 27.77, // HTML: 90px x 27.77px
                      placeholderBuilder: (context) => const Text(
                        'Poetistic',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s8), // HTML gap-2 (8px)
                  const LanguageDropdownChip(),
                ],
              ),

              // --- RIGHT SECTION ---
              // Aligned independently to the right.
              const Align(
                alignment: Alignment.centerRight,
                child: CoinPill(balance: '0'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0); // HTML: height: 60px
}
