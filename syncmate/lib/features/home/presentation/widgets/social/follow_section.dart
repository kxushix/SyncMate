import 'package:flutter/material.dart';

/// Follow section matching the HTML socials banner.
///
/// HTML definition:
/// - Container: `w-full max-w-3xl mx-auto px-6`
/// - Dividers: `border-top: 1px solid rgba(0,0,0,.08)`
/// - Inner padding: `py-3` (12px)
/// - Left content: "Follow" (text-sm, #9a9388, w500) + "@poetisticofficial" (italic, text-base, #1a1614)
/// - Right content: Instagram/YouTube buttons (36x36, bg #fff, border 1px solid rgba(26,22,20,.08), radius 10)
class FollowSection extends StatelessWidget {
  const FollowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Upper Divider (inside horizontal padding)
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0x14000000), // HTML: rgba(0,0,0,.08)
          ),

          // Row content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left content: Follow @poetisticofficial
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9A9388), // HTML: #9a9388
                      ),
                    ),
                    const SizedBox(width: 8), // HTML: gap-3
                    const Text(
                      '@poetisticofficial',
                      style: TextStyle(
                        fontSize: 14, // HTML: text-base (reduced size for mobile styling match)
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Crimson Pro',
                        color: Color(0xFF1A1614), // HTML: #1a1614
                      ),
                    ),
                  ],
                ),

                // Right content: Social buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Instagram Button
                    _SocialButton(
                      onTap: () {},
                      painter: const _InstagramPainter(),
                    ),
                    const SizedBox(width: 8), // HTML: gap-2
                    // YouTube Button
                    _SocialButton(
                      onTap: () {},
                      painter: const _YouTubePainter(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Lower Divider (inside horizontal padding)
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0x14000000), // HTML: rgba(0,0,0,.08)
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final VoidCallback onTap;
  final CustomPainter painter;

  const _SocialButton({required this.onTap, required this.painter});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0x141A1614), // HTML: rgba(26,22,20,.08)
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10), // HTML: border-radius 10px
          ),
          child: Center(
            child: SizedBox(
              width: 17,
              height: 17,
              child: CustomPaint(painter: widget.painter),
            ),
          ),
        ),
      ),
    );
  }
}

class _InstagramPainter extends CustomPainter {
  const _InstagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1614)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFF1A1614)
      ..style = PaintingStyle.fill;

    // Instagram Outer Rounded Rect (14x14 box centered in 17x17 canvas)
    final outerRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 13.5,
        height: 13.5,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(outerRRect, paint);

    // Inner Circle centered
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      3.2,
      paint,
    );

    // Top-right camera dot
    canvas.drawCircle(
      Offset(size.width / 2 + 3.8, size.height / 2 - 3.8),
      0.8,
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _YouTubePainter extends CustomPainter {
  const _YouTubePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1614)
      ..style = PaintingStyle.fill;

    // YouTube Outer Rounded Rect (15x11.5 centered)
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 15.0,
        height: 11.5,
      ),
      const Radius.circular(3.5),
    );
    canvas.drawRRect(rect, paint);

    // Play triangle (white)
    final path = Path()
      ..moveTo(size.width / 2 - 2, size.height / 2 - 3.2)
      ..lineTo(size.width / 2 - 2, size.height / 2 + 3.2)
      ..lineTo(size.width / 2 + 2.5, size.height / 2)
      ..close();

    final playPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, playPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
