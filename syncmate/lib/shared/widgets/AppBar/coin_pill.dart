import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

/// A reusable pill-shaped container for displaying coin balance.
/// 
/// Uses [BoxConstraints] to maintain a minimum width as per specifications.
class CoinPill extends StatelessWidget {
  final String balance;

  const CoinPill({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      constraints: const BoxConstraints(minWidth: 50),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.greyText ,
          width: .5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.coinIcon,
            width: 20,
            height: 20,
            placeholderBuilder: (context) => const Icon(
              Icons.monetization_on,
              size: 20,
              color: Colors.amber,
            ),
          ),
          const SizedBox(width: AppSpacing.s3),
          Text(
            balance,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
        ],
      ),
    );
  }
}
