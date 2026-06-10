import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_colors.dart';
import '../../../domain/models/poet_story.dart';
import 'story_indicator_ring.dart';

/// Individual Story Item widget matching the HTML homepage-writers-slider design.
///
/// - Avatar: 64×64 circle (HTML: `w-16 h-16`)
/// - Ring: 2px border with per-author pastel color or gradient
/// - Name: 11px, FontWeight.w500, centered, max 1 line
class StoryItem extends StatelessWidget {
  final PoetStory story;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Outer Ring with Avatar — matches HTML border-2 p-1 pattern
            StoryIndicatorRing(
              isViewed: story.isViewed,
              ringColor: story.ringColor,
              child: Container(
                width: 64, // HTML: w-16 = 64px
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(story.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  color: const Color(0xFFD9D9D9), // placeholder bg
                ),
              ),
            ),
            const SizedBox(height: 6), // HTML: mt-1 ≈ 4-6px
            // Poet Name — matches HTML `writer-name-homepage`
            SizedBox(
              width: 76,
              child: Text(
                story.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: story.isViewed ? FontWeight.w400 : FontWeight.w500,
                  color: story.isViewed
                      ? AppColors.navIconInactive
                      : AppColors.textInk,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
