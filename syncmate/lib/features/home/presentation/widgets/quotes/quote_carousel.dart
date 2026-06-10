import 'package:flutter/material.dart';
import 'package:syncmate/core/constants/app_colors.dart';
import 'package:syncmate/features/home/data/mock_quotes_data.dart';
import 'quote_card.dart';

/// Horizontally scrollable Quote Carousel — the "Today's Top 5" section.
///
/// Matches the HTML `homepage-top5-slider` design:
/// - Card width: 248px (HTML: `top5-slide: width 248px`)
/// - Card total height: 340px (302 image + 38 footer)
/// - Active card: full opacity, no transform
/// - Inactive cards: `scale(0.88) translateY(6px)` (HTML: `top5-slide-inactive`)
/// - Header: "Today's top 5", font-weight: 500, 20px
/// - Arrow buttons: circular, border 1px solid #d1d1d1
class QuoteCarousel extends StatefulWidget {
  const QuoteCarousel({super.key});

  @override
  State<QuoteCarousel> createState() => _QuoteCarouselState();
}

class _QuoteCarouselState extends State<QuoteCarousel> {
  PageController? _pageController;
  final List _quotes = MockQuotesData.getQuotes();

  static const int _initialPage = 1000;

  // HTML card dimensions
  static const double _cardWidth = QuoteCard.cardWidth; // 248px
  static const double _cardHeight =
      QuoteCard.imageHeight + QuoteCard.footerHeight; // 302 + 38 = 340px

  double _currentFraction = 0.0;
  int _activeIndex = 0;
  bool? _lastPressedIsNext;

  @override
  void initState() {
    super.initState();
    _activeIndex = _initialPage % _quotes.length;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updatePageController();
  }

  void _updatePageController() {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 0) return;

    // Gap of 10px between cards
    final double targetFraction =
        ((_cardWidth + 10) / screenWidth).clamp(0.4, 0.95);

    if (_pageController == null) {
      _currentFraction = targetFraction;
      _pageController = PageController(
        viewportFraction: _currentFraction,
        initialPage: _initialPage,
      );
      _activeIndex = _initialPage % _quotes.length;
    } else if ((_currentFraction - targetFraction).abs() > 0.001) {
      final int currentPage = _pageController!.hasClients
          ? _pageController!.page?.round() ?? _initialPage
          : _initialPage;

      setState(() {
        _currentFraction = targetFraction;
        final oldController = _pageController;
        _pageController = PageController(
          viewportFraction: _currentFraction,
          initialPage: currentPage,
        );
        _activeIndex = currentPage % _quotes.length;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          oldController?.dispose();
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _previous() {
    setState(() {
      _lastPressedIsNext = false;
    });
    _pageController?.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    setState(() {
      _lastPressedIsNext = true;
    });
    _pageController?.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = _pageController;
    if (controller == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- SECTION HEADER ---
        // HTML: font-medium text-xl = FontWeight.w500, 20px
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's top 5",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textInk,
                  letterSpacing: -0.2,
                ),
              ),
              // Arrow buttons — HTML: top5-arrow-btn (circular, 32px)
              Row(
                children: [
                  _ArrowButton(
                    isNext: false,
                    isActive: _lastPressedIsNext == false,
                    onTap: _previous,
                  ),
                  const SizedBox(width: 8),
                  _ArrowButton(
                    isNext: true,
                    isActive: _lastPressedIsNext == true,
                    onTap: _next,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // --- CAROUSEL ---
        SizedBox(
          height: _cardHeight,
          child: Stack(
            children: [
              PageView.builder(
                key: PageStorageKey('quote_carousel_$_currentFraction'),
                controller: controller,
                itemCount: 10000,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _activeIndex = index % _quotes.length;
                  });
                },
                itemBuilder: (context, index) {
                  final quote = _quotes[index % _quotes.length];

                  return AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      double offset = 0.0;
                      double scale = 0.88; // HTML: scale(.88) for inactive
                      double translateY = 6.0; // HTML: translateY(6px) for inactive

                      if (controller.position.haveDimensions) {
                        final page =
                            controller.page ?? _initialPage.toDouble();
                        offset = page - index;
                        final proximity = offset.abs().clamp(0.0, 1.0);
                        scale = (1.0 - (proximity * 0.12)).clamp(0.88, 1.0);
                        translateY =
                            (proximity * 6.0).clamp(0.0, 6.0);
                      }

                      return Transform.translate(
                        offset: Offset(0, translateY),
                        child: Transform.scale(
                          scale: scale,
                          child: Center(child: child),
                        ),
                      );
                    },
                    child: QuoteCard(quote: quote),
                  );
                },
              ),
              // Left viewport gradient overlay — HTML: .top5-slider-viewport:before
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: 56,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.3), // softer fade (30% max opacity)
                          Colors.white.withValues(alpha: 0.2), // 20%
                          Colors.white.withValues(alpha: 0.1), // 10%
                          Colors.white.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.2, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
              // Right viewport gradient overlay — HTML: .top5-slider-viewport:after
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                width: 56,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.white.withValues(alpha: 0.3), // softer fade (30% max opacity)
                          Colors.white.withValues(alpha: 0.2), // 20%
                          Colors.white.withValues(alpha: 0.1), // 10%
                          Colors.white.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.2, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24), // HTML: mt-6 (24px) below slider

        // --- CUSTOM ANIMATED DOTS INDICATOR ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_quotes.length, (index) {
            final isActive = index == _activeIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 3), // HTML: gap-x-1.5 -> 6px total gap -> 3px each side
              width: isActive ? 20.0 : 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isActive
                    ? const Color(0xFF1C1C1C) // HTML: .top5-dot--active background: #1c1c1c
                    : const Color(0x2E000000), // HTML: .top5-dot background: #0000002e
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Circular arrow navigation button.
/// HTML: `top5-arrow-btn` — 1px border, circular, 32×32
class _ArrowButton extends StatefulWidget {
  final bool isNext;
  final bool isActive;
  final VoidCallback onTap;

  const _ArrowButton({
    required this.isNext,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final showActive = widget.isActive || _isPressed;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: showActive ? const Color(0xFF1C1C1C) : Colors.transparent,
          border: Border.all(
            color: showActive ? const Color(0xFF1C1C1C) : const Color(0xFFD1D1D1),
            width: 1,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CustomPaint(
              painter: _ArrowPainter(
                isNext: widget.isNext,
                color: showActive ? Colors.white : const Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final bool isNext;
  final Color color;

  _ArrowPainter({required this.isNext, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.23237
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final s = size.width / 20.0;

    if (isNext) {
      // Line 1: M4.79279 9.5893L14.3784 9.5893
      canvas.drawLine(
        Offset(4.79279 * s, 9.5893 * s),
        Offset(14.3784 * s, 9.5893 * s),
        paint,
      );
      // Line 2: M10.4841 5.69516L14.3782 9.5893L10.4841 13.4834
      final path = Path()
        ..moveTo(10.4841 * s, 5.69516 * s)
        ..lineTo(14.3782 * s, 9.5893 * s)
        ..lineTo(10.4841 * s, 13.4834 * s);
      canvas.drawPath(path, paint);
    } else {
      // Line 1: M14.3784 9.5893L4.79279 9.5893
      canvas.drawLine(
        Offset(14.3784 * s, 9.5893 * s),
        Offset(4.79279 * s, 9.5893 * s),
        paint,
      );
      // Line 2: M8.68714 5.69537L4.793 9.58951L8.68714 13.4837
      final path = Path()
        ..moveTo(8.68714 * s, 5.69537 * s)
        ..lineTo(4.793 * s, 9.58951 * s)
        ..lineTo(8.68714 * s, 13.4837 * s);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    return oldDelegate.isNext != isNext || oldDelegate.color != color;
  }
}
