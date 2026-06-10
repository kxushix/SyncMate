import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_colors.dart';

/// Square Category Card matching the HTML `top5-type-card-inner` design.
///
/// Extracted CSS values:
/// - `aspect-ratio: 1/1` — square
/// - `border-radius: 12px`
/// - `border: 1px solid #8b8b8b`
/// - `box-shadow: 0 6px 14px rgba(0,0,0,0.08)`
/// - Gradient overlay: `linear-gradient(180deg, transparent 5%, rgba(0,0,0,0.1) 52%, #000 100%)`
/// - Title: `#fff, 14px, 700, text-shadow: 0 1px 4px rgba(0,0,0,.45)`
/// - Count badge: bg `#171717`, border `#2f2f2f`, text `#f4f4f4, 10px, 600`
///   padding `3px 7px` (mobile-optimized from HTML `max-width: 480px` breakpoint)
class CategoryCard extends StatelessWidget {
  final String title;
  final String count;
  final String imagePath;

  const CategoryCard({
    super.key,
    required this.title,
    required this.count,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0, // HTML: aspect-ratio 1/1
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9), // HTML: background-color #d9d9d9
          borderRadius: BorderRadius.circular(12), // HTML: border-radius 12px
          border: Border.all(
            color: AppColors.categoryCardBorder, // HTML: #8b8b8b
            width: 1,
          ),
          boxShadow: const [
            // HTML: box-shadow 0 6px 14px rgba(0,0,0,0.08)
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // 1. Background Image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // 2. Gradient overlay — HTML: linear-gradient(180deg, #00000005, #0000001a 52%, #000)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.52, 1.0],
                      colors: [
                        Color(0x05000000), // transparent at top
                        Color(0x1A000000), // subtle in middle
                        Color(0xFF000000), // solid black at bottom
                      ],
                    ),
                  ),
                ),
              ),

              // 3. Footer content — HTML: top5-type-card-footer, padding 8px 10px
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 6, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title — HTML: top5-type-card-title (mobile: 14px)
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12, // HTML mobile: 14px
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                            shadows: [
                              Shadow(
                                // HTML: text-shadow 0 1px 4px rgba(0,0,0,.45)
                                color: Color(0x73000000),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      // Count badge — HTML: top5-type-card-count (pill: 29.83 x 18)
                      Container(
                        width: 29.83,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.categoryBadgeBg, // #171717
                          borderRadius: BorderRadius.circular(9999),
                          border: Border.all(
                            color: AppColors.categoryBadgeBorder, // #2f2f2f
                            width: 1,
                          ),
                        ),
                        child: Text(
                          count,
                          style: const TextStyle(
                            color: AppColors.categoryBadgeText, // #f4f4f4
                            fontSize: 8, // HTML mobile: 10px
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
