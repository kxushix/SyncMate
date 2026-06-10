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
      backgroundColor: AppColors.background,
      appBar: const CustomHomeAppBar(),
      body: navigationShell,
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
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final int currentIndex = navigationShell.currentIndex;

    return Container(
      // HTML: padding: 12px 6px calc(env(safe-area-inset-bottom,0px) + 8px)
      height: 68 + bottomPadding,
      decoration: const BoxDecoration(
        color: Colors.white, // HTML: background #fff
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22), // HTML: border-radius 22px 22px 0 0
          topRight: Radius.circular(22),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A1A1614), // softer 4% opacity
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
          BoxShadow(
            color: Color(0x081A1614), // softer 3% opacity
            blurRadius: 4,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Viewport gradient overlay above nav bar — HTML: .bnav:before
          Positioned(
            top: -56,
            left: 0,
            right: 0,
            height: 56,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0.66), // softer fade (50% max opacity)
                      Colors.white.withValues(alpha: 0.40), // softer fade (25%)
                      Colors.white.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
              ),
            ),
          ),
          // Standard nav items row
          Padding(
            padding: EdgeInsets.only(
              bottom: bottomPadding,
              top: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Home
                _BNavItem(
                  label: 'Home',
                  isActive: currentIndex == 0,
                  onTap: () => _onTap(context, 0),
                  outlinedIcon: const _HomeIconOutline(),
                  filledIcon: const _HomeIconFilled(),
                ),
                // Explore
                _BNavItem(
                  label: 'Explore',
                  isActive: currentIndex == 1,
                  onTap: () => _onTap(context, 1),
                  outlinedIcon: const _ExploreIconOutline(),
                  filledIcon: const _ExploreIconFilled(),
                ),
                // Spacer for the floating create button
                const SizedBox(width: 65),
                // Library
                _BNavItem(
                  label: 'Library',
                  isActive: currentIndex == 3,
                  onTap: () => _onTap(context, 3),
                  outlinedIcon: const _LibraryIconOutline(),
                  filledIcon: const _LibraryIconFilled(),
                ),
                // Profile
                _BNavItem(
                  label: 'Profile',
                  isActive: currentIndex == 4,
                  onTap: () => _onTap(context, 4),
                  outlinedIcon: const _ProfileIconOutline(),
                  filledIcon: const _ProfileIconFilled(),
                ),
              ],
            ),
          ),

          // Floating Create/Submit button — HTML: bnav-create-btn
          // margin-top: -44px (overlaps top edge), 65x65px circle, bg #1c1c1c
          Positioned(
            top: -32, // Overlaps the nav bar top edge
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CreateButton(
                  onTap: () => _onTap(context, 2),
                  isActive: currentIndex == 2,
                ),
                const SizedBox(height: 6),
                // HTML: bnav-label--create
                Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: currentIndex == 2
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: const Color(0xFF1C1C1C), // HTML: #1c1c1c
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

/// A single bottom nav item — HTML `bnav-item`.
///
/// Shows [filledIcon] when active (HTML: `ico-filled`), [outlinedIcon] otherwise.
/// Label: 10px, w500 inactive → w600 active (HTML: bnav-label)
class _BNavItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Widget outlinedIcon;
  final Widget filledIcon;

  const _BNavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.outlinedIcon,
    required this.filledIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        // HTML: flex-direction column, gap 6px, padding 2px 0
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon — toggle between filled and outline
            isActive ? filledIcon : outlinedIcon,
            const SizedBox(height: 6), // HTML: gap 6px
            Text(
              label,
              style: TextStyle(
                fontSize: 10, // HTML: font-size 10px
                fontWeight:
                    isActive ? FontWeight.w600 : FontWeight.w500, // HTML
                color: const Color(0xFF1C1C1C), // HTML: color #1c1c1c
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating create button — HTML `bnav-create-btn`:
/// - bg: #1c1c1c
/// - border: 2px solid #fff
/// - border-radius: 50%
/// - width: 65px, height: 65px
/// - margin-top: -44px (handled by Stack positioning)
class _CreateButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isActive;

  const _CreateButton({required this.onTap, required this.isActive});

  @override
  State<_CreateButton> createState() => _CreateButtonState();
}

class _CreateButtonState extends State<_CreateButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: 65, // HTML: width: 65px
          height: 65, // HTML: height: 65px
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C), // HTML: background #1c1c1c
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2), // HTML: border 2px solid #fff
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.submitIcon,
              width: 18, // HTML: width 17.62px height 38.77px
              height: 39,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              placeholderBuilder: (_) => const Icon(
                Icons.edit_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SVG Icon Widgets — built from exact SVG paths extracted from hindi.html
// Each icon has an Outline (inactive) and Filled (active) variant.
// =============================================================================

/// HOME ICON (Outline) — HTML lines 8072-8075
class _HomeIconOutline extends StatelessWidget {
  const _HomeIconOutline();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _HomeOutlinePainter()),
    );
  }
}

/// HOME ICON (Filled) — HTML line 8076
class _HomeIconFilled extends StatelessWidget {
  const _HomeIconFilled();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _HomeFilledPainter()),
    );
  }
}

/// EXPLORE ICON (Outline) — HTML lines 8083-8086
class _ExploreIconOutline extends StatelessWidget {
  const _ExploreIconOutline();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _ExploreOutlinePainter()),
    );
  }
}

/// EXPLORE ICON (Filled) — HTML lines 8089-8092
class _ExploreIconFilled extends StatelessWidget {
  const _ExploreIconFilled();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _ExploreFilledPainter()),
    );
  }
}

/// LIBRARY ICON (Outline) — HTML lines 8108-8111
class _LibraryIconOutline extends StatelessWidget {
  const _LibraryIconOutline();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _LibraryOutlinePainter()),
    );
  }
}

/// LIBRARY ICON (Filled) — HTML lines 8114-8115
class _LibraryIconFilled extends StatelessWidget {
  const _LibraryIconFilled();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _LibraryFilledPainter()),
    );
  }
}

/// PROFILE ICON (Outline) — HTML lines 8123-8124 (no filled variant in HTML)
class _ProfileIconOutline extends StatelessWidget {
  const _ProfileIconOutline();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _ProfileOutlinePainter()),
    );
  }
}

/// PROFILE ICON (Filled) — same paths but filled (stroke becomes fill)
class _ProfileIconFilled extends StatelessWidget {
  const _ProfileIconFilled();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _ProfileFilledPainter()),
    );
  }
}

// =============================================================================
// CUSTOM PAINTERS — draw the SVG paths directly
// Scale: viewBox 0 0 24 24, canvas 24×24, so scale = 1.0
// =============================================================================

const _kIconColor = Color(0xFF1C1C1C);

class _HomeOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 24;

    // Path: "M12 18V15"
    final p1 = Path()
      ..moveTo(12 * s, 18 * s)
      ..lineTo(12 * s, 15 * s);
    canvas.drawPath(p1, paint);

    // Path: house outline
    final p2 = Path();
    p2.moveTo(10.07 * s, 2.82 * s);
    p2.lineTo(3.14 * s, 8.37 * s);
    p2.cubicTo(2.36 * s, 8.99 * s, 1.86 * s, 10.3 * s, 2.03 * s, 11.28 * s);
    p2.lineTo(3.36 * s, 19.24 * s);
    p2.cubicTo(3.6 * s, 20.66 * s, 4.96 * s, 21.81 * s, 6.4 * s, 21.81 * s);
    p2.lineTo(17.6 * s, 21.81 * s);
    p2.cubicTo(19.03 * s, 21.81 * s, 20.4 * s, 20.65 * s, 20.64 * s, 19.24 * s);
    p2.lineTo(21.97 * s, 11.28 * s);
    p2.cubicTo(22.13 * s, 10.3 * s, 21.63 * s, 8.99 * s, 20.86 * s, 8.37 * s);
    p2.lineTo(13.93 * s, 2.83 * s);
    p2.cubicTo(12.86 * s, 1.97 * s, 11.13 * s, 1.97 * s, 10.07 * s, 2.82 * s);
    p2.close();
    canvas.drawPath(p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeFilledPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 24;

    // Filled house shape
    final p = Path();
    p.moveTo(20.83 * s, 8.01 * s);
    p.lineTo(14.28 * s, 2.77 * s);
    p.cubicTo(13 * s, 1.75 * s, 11 * s, 1.74 * s, 9.73 * s, 2.76 * s);
    p.lineTo(3.18 * s, 8.01 * s);
    p.cubicTo(2.24 * s, 8.76 * s, 1.67 * s, 10.26 * s, 1.87 * s, 11.44 * s);
    p.lineTo(3.13 * s, 18.98 * s);
    p.cubicTo(3.42 * s, 20.67 * s, 4.99 * s, 22 * s, 6.7 * s, 22 * s);
    p.lineTo(17.3 * s, 22 * s);
    p.cubicTo(18.99 * s, 22 * s, 20.59 * s, 20.64 * s, 20.88 * s, 18.97 * s);
    p.lineTo(22.14 * s, 11.43 * s);
    p.cubicTo(22.32 * s, 10.26 * s, 21.75 * s, 8.76 * s, 20.83 * s, 8.01 * s);
    p.close();
    canvas.drawPath(p, paint);

    // Door line in white
    final door = Path()
      ..moveTo(12 * s, 18 * s)
      ..lineTo(12 * s, 15 * s);
    canvas.drawPath(door, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ExploreOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 24;

    // Outer rounded square
    final p1 = Path();
    p1.moveTo(9 * s, 22 * s);
    p1.lineTo(15 * s, 22 * s);
    p1.cubicTo(20 * s, 22 * s, 22 * s, 20 * s, 22 * s, 15 * s);
    p1.lineTo(22 * s, 9 * s);
    p1.cubicTo(22 * s, 4 * s, 20 * s, 2 * s, 15 * s, 2 * s);
    p1.lineTo(9 * s, 2 * s);
    p1.cubicTo(4 * s, 2 * s, 2 * s, 4 * s, 2 * s, 9 * s);
    p1.lineTo(2 * s, 15 * s);
    p1.cubicTo(2 * s, 20 * s, 4 * s, 22 * s, 9 * s, 22 * s);
    p1.close();
    canvas.drawPath(p1, paint);

    // Vertical divider
    canvas.drawLine(Offset(12 * s, 2 * s), Offset(12 * s, 22 * s), paint);
    // Top horizontal
    canvas.drawLine(Offset(2 * s, 9.5 * s), Offset(12 * s, 9.5 * s), paint);
    // Bottom horizontal
    canvas.drawLine(Offset(12 * s, 14.5 * s), Offset(22 * s, 14.5 * s), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ExploreFilledPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..style = PaintingStyle.fill;

    final s = size.width / 24;

    // Top-right quadrant
    final p1 = Path();
    p1.moveTo(16.19 * s, 2 * s);
    p1.lineTo(12.75 * s, 2 * s);
    p1.lineTo(12.75 * s, 13.75 * s);
    p1.lineTo(22 * s, 13.75 * s);
    p1.lineTo(22 * s, 7.81 * s);
    p1.cubicTo(22 * s, 4.17 * s, 19.83 * s, 2 * s, 16.19 * s, 2 * s);
    p1.close();
    canvas.drawPath(p1, paint);

    // Bottom-left quadrant
    final p2 = Path();
    p2.moveTo(2 * s, 10.25 * s);
    p2.lineTo(11.25 * s, 10.25 * s);
    p2.lineTo(11.25 * s, 22 * s);
    p2.lineTo(7.81 * s, 22 * s);
    p2.cubicTo(4.17 * s, 22 * s, 2 * s, 19.83 * s, 2 * s, 16.19 * s);
    p2.lineTo(2 * s, 10.25 * s);
    p2.close();
    canvas.drawPath(p2, paint);

    // Top-left quadrant
    final p3 = Path();
    p3.moveTo(11.25 * s, 2 * s);
    p3.lineTo(7.81 * s, 2 * s);
    p3.cubicTo(4.17 * s, 2 * s, 2 * s, 4.17 * s, 2 * s, 7.81 * s);
    p3.lineTo(2 * s, 8.75 * s);
    p3.lineTo(11.25 * s, 8.75 * s);
    p3.lineTo(11.25 * s, 2 * s);
    p3.close();
    canvas.drawPath(p3, paint);

    // Bottom-right quadrant
    final p4 = Path();
    p4.moveTo(22 * s, 15.25 * s);
    p4.lineTo(12.75 * s, 15.25 * s);
    p4.lineTo(12.75 * s, 22 * s);
    p4.lineTo(16.19 * s, 22 * s);
    p4.cubicTo(19.83 * s, 22 * s, 22 * s, 19.83 * s, 22 * s, 16.19 * s);
    p4.lineTo(22 * s, 15.25 * s);
    p4.close();
    canvas.drawPath(p4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LibraryOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 24;

    // Book outline path
    final p1 = Path();
    p1.moveTo(22 * s, 16.74 * s);
    p1.lineTo(22 * s, 4.67 * s);
    p1.cubicTo(22 * s, 3.47 * s, 21.02 * s, 2.58 * s, 19.83 * s, 2.68 * s);
    p1.lineTo(19.77 * s, 2.68 * s);
    p1.cubicTo(17.67 * s, 2.86 * s, 14.48 * s, 3.93 * s, 12.7 * s, 5.05 * s);
    p1.lineTo(12.53 * s, 5.16 * s);
    p1.cubicTo(12.24 * s, 5.34 * s, 11.76 * s, 5.34 * s, 11.47 * s, 5.16 * s);
    p1.lineTo(11.22 * s, 5.01 * s);
    p1.cubicTo(9.44 * s, 3.9 * s, 6.26 * s, 2.84 * s, 4.16 * s, 2.67 * s);
    p1.cubicTo(2.97 * s, 2.57 * s, 2 * s, 3.47 * s, 2 * s, 4.66 * s);
    p1.lineTo(2 * s, 16.74 * s);
    p1.cubicTo(2 * s, 17.7 * s, 2.78 * s, 18.6 * s, 3.74 * s, 18.72 * s);
    p1.lineTo(4.03 * s, 18.76 * s);
    p1.cubicTo(6.2 * s, 19.05 * s, 9.55 * s, 20.15 * s, 11.47 * s, 21.2 * s);
    p1.lineTo(11.51 * s, 21.22 * s);
    p1.cubicTo(11.78 * s, 21.37 * s, 12.21 * s, 21.37 * s, 12.47 * s, 21.22 * s);
    p1.cubicTo(14.39 * s, 20.16 * s, 17.75 * s, 19.05 * s, 19.93 * s, 18.76 * s);
    p1.lineTo(20.26 * s, 18.72 * s);
    p1.cubicTo(21.22 * s, 18.6 * s, 22 * s, 17.7 * s, 22 * s, 16.74 * s);
    p1.close();
    canvas.drawPath(p1, paint);

    // Center spine
    canvas.drawLine(Offset(12 * s, 5.49 * s), Offset(12 * s, 20.49 * s), paint);
    // Left lines
    canvas.drawLine(Offset(7.75 * s, 8.49 * s), Offset(5.5 * s, 8.49 * s), paint);
    canvas.drawLine(Offset(8.5 * s, 11.49 * s), Offset(5.5 * s, 11.49 * s), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LibraryFilledPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..style = PaintingStyle.fill;

    final s = size.width / 24;

    // Right side (dark cover)
    final p1 = Path();
    p1.moveTo(22 * s, 4.85 * s);
    p1.lineTo(22 * s, 16.74 * s);
    p1.cubicTo(22 * s, 17.71 * s, 21.21 * s, 18.6 * s, 20.24 * s, 18.72 * s);
    p1.lineTo(19.93 * s, 18.76 * s);
    p1.cubicTo(18.29 * s, 18.98 * s, 15.98 * s, 19.66 * s, 14.12 * s, 20.44 * s);
    p1.cubicTo(13.47 * s, 20.71 * s, 12.75 * s, 20.22 * s, 12.75 * s, 19.51 * s);
    p1.lineTo(12.75 * s, 5.6 * s);
    p1.cubicTo(12.75 * s, 5.23 * s, 12.96 * s, 4.89 * s, 13.29 * s, 4.71 * s);
    p1.cubicTo(15.12 * s, 3.72 * s, 17.89 * s, 2.84 * s, 19.77 * s, 2.68 * s);
    p1.lineTo(19.83 * s, 2.68 * s);
    p1.cubicTo(21.03 * s, 2.68 * s, 22 * s, 3.65 * s, 22 * s, 4.85 * s);
    p1.close();
    canvas.drawPath(p1, paint);

    // Left side (with lines cutout via white paint)
    final p2 = Path();
    p2.moveTo(10.71 * s, 4.71 * s);
    p2.cubicTo(8.88 * s, 3.72 * s, 6.11 * s, 2.84 * s, 4.23 * s, 2.68 * s);
    p2.lineTo(4.16 * s, 2.68 * s);
    p2.cubicTo(2.96 * s, 2.68 * s, 1.99 * s, 3.65 * s, 1.99 * s, 4.85 * s);
    p2.lineTo(1.99 * s, 16.74 * s);
    p2.cubicTo(1.99 * s, 17.71 * s, 2.78 * s, 18.6 * s, 3.75 * s, 18.72 * s);
    p2.lineTo(4.06 * s, 18.76 * s);
    p2.cubicTo(5.7 * s, 18.98 * s, 8.01 * s, 19.66 * s, 9.87 * s, 20.44 * s);
    p2.cubicTo(10.52 * s, 20.71 * s, 11.24 * s, 20.22 * s, 11.24 * s, 19.51 * s);
    p2.lineTo(11.24 * s, 5.6 * s);
    p2.cubicTo(11.24 * s, 5.22 * s, 11.04 * s, 4.89 * s, 10.71 * s, 4.71 * s);
    p2.close();
    canvas.drawPath(p2, paint);

    // White lines on left side for legibility
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(5 * s, 8.49 * s), Offset(7.25 * s, 8.49 * s), linePaint);
    canvas.drawLine(Offset(5 * s, 11.49 * s), Offset(8 * s, 11.49 * s), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProfileOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 24;

    // Head circle
    final head = Path();
    head.moveTo(12.16 * s, 10.87 * s);
    head.cubicTo(12.06 * s, 10.86 * s, 11.94 * s, 10.86 * s, 11.83 * s, 10.87 * s);
    head.cubicTo(9.45 * s, 10.79 * s, 7.56 * s, 8.84 * s, 7.56 * s, 6.44 * s);
    head.cubicTo(7.56 * s, 3.99 * s, 9.54 * s, 2 * s, 12 * s, 2 * s);
    head.cubicTo(14.45 * s, 2 * s, 16.44 * s, 3.99 * s, 16.44 * s, 6.44 * s);
    head.cubicTo(16.43 * s, 8.84 * s, 14.54 * s, 10.79 * s, 12.16 * s, 10.87 * s);
    head.close();
    canvas.drawPath(head, paint);

    // Body ellipse
    final body = Path();
    body.moveTo(7.16 * s, 14.56 * s);
    body.cubicTo(4.74 * s, 16.18 * s, 4.74 * s, 18.82 * s, 7.16 * s, 20.43 * s);
    body.cubicTo(9.91 * s, 22.27 * s, 14.42 * s, 22.27 * s, 17.17 * s, 20.43 * s);
    body.cubicTo(19.59 * s, 18.81 * s, 19.59 * s, 16.17 * s, 17.17 * s, 14.56 * s);
    body.cubicTo(14.43 * s, 12.73 * s, 9.92 * s, 12.73 * s, 7.16 * s, 14.56 * s);
    body.close();
    canvas.drawPath(body, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProfileFilledPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kIconColor
      ..style = PaintingStyle.fill;

    final s = size.width / 24;

    // Filled head circle (drawn as an oval using a path)
    final headRect = Rect.fromCenter(
      center: Offset(12 * s, 6.5 * s),
      width: 9 * s,
      height: 9 * s,
    );
    canvas.drawOval(headRect, paint);

    // Filled body ellipse
    final bodyRect = Rect.fromCenter(
      center: Offset(12 * s, 17.5 * s),
      width: 13 * s,
      height: 7 * s,
    );
    canvas.drawOval(bodyRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
