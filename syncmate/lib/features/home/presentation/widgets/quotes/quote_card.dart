import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_colors.dart';
import 'package:syncmate/features/home/domain/models/quote_card_model.dart';
import 'quote_action_bar.dart';

/// A pixel-perfect Quote Card widget matching the HTML `top5-card` design.
///
/// Dimensions (from HTML CSS):
/// - Card width: 248px
/// - Image area height: 302px  (`top5-card-image: height 302px`)
/// - Footer height: 38px       (`top5-card-footer: min-height 38px`)
/// - Total height: 340px
/// - Border radius: 12px
///
/// Features:
/// - Background image fills the top 302px area
/// - Gift pill (yellow) in top-right corner
/// - Dynamic text positioned absolutely within image area
/// - Solid `#050505` footer bar with action icons
class QuoteCard extends StatelessWidget {
  final QuoteCardModel quote;

  const QuoteCard({super.key, required this.quote});

  static const double cardWidth = 248.0;
  static const double imageHeight = 302.0;
  static const double footerHeight = 38.0;

  @override
  Widget build(BuildContext context) {
    final displayColor = _parseHexColor(quote.textColor);
    final translateX = _getTranslateX(quote.textAlign);

    return SizedBox(
      width: cardWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // HTML: border-radius 12px
        child: Container(
          color: AppColors.actionBarBg, // Prevents subpixel gaps showing background color
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- IMAGE AREA (302px) ---
              SizedBox(
                width: cardWidth,
                height: imageHeight,
                child: Stack(
                  children: [
                    // 1. Full background image
                    Positioned.fill(
                      child: Image.asset(
                        quote.backgroundImage,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // 2. Dynamic quote text positioned absolutely per model
                    Positioned(
                      left: cardWidth * quote.leftPercent,
                      top: imageHeight * quote.topPercent,
                      child: FractionalTranslation(
                        translation: Offset(translateX, 0.0),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: cardWidth * 0.92, // HTML: max-width: 92%
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                quote.quote,
                                textAlign: quote.textAlign,
                                style: TextStyle(
                                  color: displayColor,
                                  // HTML: font-size clamp(12px, 5cqw, 16px) → 12.4px
                                  fontSize: 12.4,
                                  fontWeight: FontWeight.w600,
                                  // HTML: line-height 1.35
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Author name — HTML: font-size clamp(10px,4.28cqw,12px) → 10.6px
                              Text(
                                quote.author,
                                textAlign: quote.textAlign,
                                style: TextStyle(
                                  color: displayColor.withValues(alpha: 0.95),
                                  fontSize: 10.6,
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // 3. Gift pill — top-right (HTML: top5-gift-pill)
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: _GiftPill(),
                    ),
                  ],
                ),
              ),

              // --- ACTION BAR FOOTER (38px) ---
              QuoteActionBar(
                likeCount: quote.likeCount,
                isLiked: quote.isLiked,
                isSaved: quote.isSaved,
                onLike: () {},
                onShare: () {},
                onSend: () {},
                onDownload: () {},
                onSave: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }


  double _getTranslateX(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.center:
        return -0.5;
      case TextAlign.right:
        return -1.0;
      case TextAlign.left:
      default:
        return 0.0;
    }
  }

  Color _parseHexColor(String hex) {
    final cleanHex = hex.replaceAll('#', '');
    if (cleanHex.length == 6) {
      return Color(int.parse('FF$cleanHex', radix: 16));
    } else if (cleanHex.length == 8) {
      return Color(int.parse(cleanHex, radix: 16));
    }
    return Colors.white; // fallback
  }
}

/// Gift pill badge — HTML `top5-gift-pill`:
/// - bg: #fc0 (yellow)
/// - border: 0.7px solid #fff
/// - border-radius: 12px
/// - height: 26px
/// - font: 12px bold
class _GiftPill extends StatelessWidget {
  const _GiftPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFCC00), // HTML: #fc0
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 0.7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.card_giftcard_rounded,
            size: 13,
            color: Color(0xFF040404),
          ),
          SizedBox(width: 4),
          Text(
            'Gift',
            style: TextStyle(
              color: Color(0xFF040404),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.01,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
