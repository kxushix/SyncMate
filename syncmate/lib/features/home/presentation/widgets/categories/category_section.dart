import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_assets.dart';

import 'category_card.dart';

/// A horizontal 3-column grid of Category Cards (Sher, Ghazal, Nazm).
///
/// Matches the HTML `top5-types-grid` section:
/// - `px-6 my-8` → horizontal: 24px, vertical: 32px
/// - Section header: `font-medium text-xl` → FontWeight.w500, 20px
/// - `gap: 12px` between cards
/// - "See all" link at right of header
class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // HTML: px-6 = 24px, my-8 = 32px (simulating collapsed margins)
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cards row with gap 12px — HTML: top5-types-grid gap: 12px
          Row(
            children: [
              Expanded(
                child: CategoryCard(
                  title: 'Sher',
                  count: '71k',
                  imagePath: AppAssets.categorySher,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CategoryCard(
                  title: 'Ghazal',
                  count: '56k',
                  imagePath: AppAssets.categoryGhazal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CategoryCard(
                  title: 'Nazm',
                  count: '6k',
                  imagePath: AppAssets.categoryNazm,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
