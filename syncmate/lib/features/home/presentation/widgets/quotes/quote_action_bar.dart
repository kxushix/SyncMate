import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncmate/core/constants/app_assets.dart';
import 'package:syncmate/core/constants/app_colors.dart';

/// Bottom interaction bar for Quote Cards.
///
/// Matches the HTML `top5-card-footer` design exactly:
/// - Background: solid `#050505`
/// - Min height: 38px, padding: 10px vertical / 12px horizontal
/// - Left: Heart icon + like count, Share icon, Send icon (gap: 12px)
/// - Right: Download icon, Save/Bookmark icon (gap: 12px)
/// - Icon size: 18×18px
class QuoteActionBar extends StatelessWidget {
  final int likeCount;
  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLike;
  final VoidCallback onShare;
  final VoidCallback onSend;
  final VoidCallback onDownload;
  final VoidCallback onSave;

  const QuoteActionBar({
    super.key,
    required this.likeCount,
    this.isLiked = false,
    this.isSaved = false,
    required this.onLike,
    required this.onShare,
    required this.onSend,
    required this.onDownload,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // HTML: min-height 38px, padding 10px 12px
      constraints: const BoxConstraints(minHeight: 38),
      color: AppColors.actionBarBg, // #050505
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // --- LEFT ACTIONS: like, share, send (gap: 12px) ---
          _LikeButton(count: likeCount, isLiked: isLiked, onTap: onLike),
          const SizedBox(width: 12),
          _ActionIcon(assetPath: AppAssets.iconShare, onTap: onShare),
          const SizedBox(width: 12),
          _ActionIcon(assetPath: AppAssets.iconSend, onTap: onSend),

          const Spacer(),

          // --- RIGHT ACTIONS: download, save (gap: 12px) ---
          _ActionIcon(assetPath: AppAssets.iconDownload, onTap: onDownload),
          const SizedBox(width: 12),
          _ActionIcon(
            assetPath: AppAssets.iconSave,
            onTap: onSave,
            color: isSaved ? const Color(0xFFFFD301) : Colors.white,
          ),
        ],
      ),
    );
  }
}

/// Like button with heart icon and count — HTML `top5-card-like-btn`
class _LikeButton extends StatelessWidget {
  final int count;
  final bool isLiked;
  final VoidCallback onTap;

  const _LikeButton({
    required this.count,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isLiked ? const Color(0xFFFF3B5B) : Colors.white,
            size: 18,
          ),
          const SizedBox(width: 4),
          // HTML: top5-like-count — font-size: 12px, font-weight: 500
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small SVG icon button — HTML `top5-card-icon-btn`
class _ActionIcon extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  final Color color;

  const _ActionIcon({
    required this.assetPath,
    required this.onTap,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SvgPicture.asset(
        assetPath,
        width: 18, // HTML: 18×18px
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        placeholderBuilder: (_) => Icon(
          Icons.broken_image_outlined,
          color: color,
          size: 18,
        ),
      ),
    );
  }
}
