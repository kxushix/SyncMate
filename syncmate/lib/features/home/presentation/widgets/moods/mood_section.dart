import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_assets.dart';
import 'package:syncmate/core/constants/app_colors.dart';
import 'mood_card.dart';

/// A section displaying poetic moods in a 2-column grid.
///
/// Matches the HTML moods section design:
/// - Header: "Moods", `font-medium text-xl` → FontWeight.w500, 20px
/// - "All moods" link at right (muted color)
/// - 2-column grid, `gap: 12px`
/// - Padding: `px-6 my-8` → horizontal: 24px, vertical: 32px
class MoodSection extends StatelessWidget {
  const MoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // HTML: px-6 my-8 → horizontal: 24px, bottom: 32px (simulating collapsed margins)
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Moods',
                style: TextStyle(
                  fontSize: 20, // HTML: text-xl
                  fontWeight: FontWeight.bold,
                  color: AppColors.textInk,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'See all >',
                  style: TextStyle(
                    color: Color(0xFF9A9388), // HTML muted gray
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 2-column grid with gap: 12px (HTML: top5-types-grid pattern)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: MoodCard(
                  quote:
                      'तेरा चुप रहना मेरे ज़ेहन में क्या बैठ गया\nइतनी आवाज़ें तुझे दीं कि गला बैठ गया',
                  hindiTitle: 'ज़िंदगी',
                  englishTitle: 'life',
                  backgroundImage: AppAssets.quoteBg1,
                ),
              ),
              const SizedBox(width: 12), // HTML: gap: 12px
              const Expanded(
                child: MoodCard(
                  quote:
                      'शाखों से टूट जाएँ वो पत्ते नहीं हैं हम\nआँधी से कोई कह दे कि औक़ात में रहे',
                  hindiTitle: 'मोटिवेशनल',
                  englishTitle: 'motivational',
                  backgroundImage: AppAssets.quoteBg3,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12), // HTML: gap: 12px

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: MoodCard(
                  quote:
                      'तुम बहुत याद आए आज मुझे\nवैसे हर इक की अपनी मर्ज़ी है',
                  hindiTitle: 'सैड',
                  englishTitle: 'sad',
                  backgroundImage: AppAssets.quoteBg3,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: MoodCard(
                  quote:
                      'तुम्हारे शहर का मौसम बड़ा सुहाना लगे\nमैं एक शाम चुरा लूँ अगर बुरा न लगे',
                  hindiTitle: 'रोमांटिक',
                  englishTitle: 'romantic',
                  backgroundImage: AppAssets.quoteBg1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
