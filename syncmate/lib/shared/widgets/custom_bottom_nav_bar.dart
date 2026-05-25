import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';


import 'AppBar/custom_home_app_bar.dart';

class MainNavigationWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The global app bar that appears on all screens
      appBar: const CustomHomeAppBar(),
      // The body is the navigation shell which contains the current tab's screen
      body: navigationShell,
      // Custom implementation to allow the center button to overlap
      bottomNavigationBar: CustomBottomNavBar(navigationShell: navigationShell),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavBar({super.key, required this.navigationShell});

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      // Maintains state and handles navigation naturally
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bottom padding for devices with safe area (like iPhone notches)
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 70 + bottomPadding,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Row for the standard nav items
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Icons.home_filled,
                  label: 'Home',
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => _onTap(context, 0),
                ),
                _NavBarItem(
                  icon: Icons.explore,
                  label: 'Explore',
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: () => _onTap(context, 1),
                ),
                // Spacer for the center floating button
                const SizedBox(width: 65),
                _NavBarItem(
                  icon: Icons.library_books,
                  label: 'Library',
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: () => _onTap(context, 3),
                ),
                _NavBarItem(
                  icon: Icons.person,
                  label: 'Profile',
                  isSelected: navigationShell.currentIndex == 4,
                  onTap: () => _onTap(context, 4),
                ),
              ],
            ),
          ),

          // Floating Center Submit Button with Label
          Positioned(
            top: -30, // Overlap the top edge
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SubmitFloatingButton(
                  onTap: () => _onTap(context, 2),
                  isSelected: navigationShell.currentIndex == 2,
                ),
                const SizedBox(height: 10), // Space between button and label
                Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: navigationShell.currentIndex == 2
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: navigationShell.currentIndex == 2
                        ? AppColors.navIconActive
                        : AppColors.navIconInactive,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.navIconActive
                  : AppColors.navIconInactive,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.navIconActive
                    : AppColors.navIconInactive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitFloatingButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;

  const _SubmitFloatingButton({required this.onTap, required this.isSelected});

  @override
  State<_SubmitFloatingButton> createState() => _SubmitFloatingButtonState();
}

class _SubmitFloatingButtonState extends State<_SubmitFloatingButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.submitIcon,
              width: 17,
              height: 38,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (context) =>
                  const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ),
        ),
      ),
    );
  }
}
