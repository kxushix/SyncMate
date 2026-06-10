import 'package:flutter/material.dart';

/// A premium card representing a poetic mood.
///
/// Matches the HTML `mood-card` / `top5-card` inner design:
/// - `aspect-ratio: 4/5` — using AspectRatio widget
/// - `border-radius: 12px` (changed from 20)
/// - Gradient overlay: transparent → subtle black → solid black
/// - Top: quote text in white
/// - Bottom: Hindi title (small, light) + English title (bold) + arrow button
class MoodCard extends StatelessWidget {
  final String quote;
  final String hindiTitle;
  final String englishTitle;
  final String backgroundImage;

  const MoodCard({
    super.key,
    required this.quote,
    required this.hindiTitle,
    required this.englishTitle,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5, // HTML: aspect-ratio 4/5
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // HTML: border-radius 12px
        child: Stack(
          children: [
            // 1. Background Image
            Positioned.fill(
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
              ),
            ),

            // 2. Dual gradient — same as HTML mood card overlay logic
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.3, 0.6, 1.0],
                    colors: [
                      Color(0x70000000), // dark at top for text readability
                      Color(0x00000000), // transparent in middle
                      Color(0x33000000), // subtle
                      Color(0xCC000000), // solid dark at bottom
                    ],
                  ),
                ),
              ),
            ),

            // 3. Content
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Quote Text — HTML: text-[11px] font-medium drop-shadow
                  Text(
                    quote,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11, // HTML: 11px
                      fontWeight: FontWeight.w500, // HTML: font-medium
                      height: 1.4,
                      shadows: [
                        Shadow(
                          color: Color(0x99000000),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Bottom: Labels + Arrow Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hindi title — HTML: text-[9px] uppercase tracking-[0.06em] text-[#ffffffa3] font-medium
                            Text(
                              hindiTitle.toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xA3FFFFFF), // HTML: #ffffffa3
                                fontSize: 9, // HTML: 9px
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.54, // 0.06em
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 2), // HTML: mt-0.5
                            // English title — HTML: text-base font-bold capitalize mt-0.5
                            Text(
                              englishTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15, // HTML: text-base (15px)
                                fontWeight: FontWeight.w700,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Circular arrow button — HTML: w-4.5 h-4.5 bg-white rounded-full (18x18)
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CustomPaint(
                              painter: _MoodArrowPainter(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodArrowPainter extends CustomPainter {
  const _MoodArrowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1C1C1C)
      ..strokeWidth = 0.886073
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 18.0;

    // Path 1: M6.42445 11.2979L11.2979 6.42445
    canvas.drawLine(
      Offset(6.42445 * s, 11.2979 * s),
      Offset(11.2979 * s, 6.42445 * s),
      paint,
    );

    // Path 2: M7.33821 6.42464L11.2979 6.42464L11.2979 10.3843
    final path = Path()
      ..moveTo(7.33821 * s, 6.42464 * s)
      ..lineTo(11.2979 * s, 6.42464 * s)
      ..lineTo(11.2979 * s, 10.3843 * s);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
