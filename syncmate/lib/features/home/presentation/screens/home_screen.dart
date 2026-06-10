import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_colors.dart';
import '../widgets/stories/stories_section.dart';
import '../widgets/quotes/quote_carousel.dart';
import '../widgets/categories/category_section.dart';
import '../widgets/moods/mood_section.dart';
import '../widgets/social/follow_section.dart';
import '../widgets/footer/footer_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // #f5f4f0 warm parchment
      // The Global App Bar is provided by MainNavigationWrapper
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Stories / Writers Slider — HTML: homepage-writers-slider my-3
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: StoriesSection(),
            ),

            // Social Follow banner
            const FollowSection(),

            const SizedBox(height: 16), // Margin between follow row and Today's Top 5 (HTML mb-8 mt-4)

            // 2. Quote Cards Carousel — HTML: px-6 mb-8 mt-4
            const QuoteCarousel(),

            // 3. Category Cards (Sher, Ghazal, Nazm) — HTML: px-6 my-8
            const CategorySection(),

            // 4. Mood Cards Grid — HTML: px-6 my-8
            const MoodSection(),

            // Footer Section
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
