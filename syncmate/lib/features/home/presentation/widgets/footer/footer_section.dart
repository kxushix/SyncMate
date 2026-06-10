import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncmate/core/constants/app_assets.dart';

/// A production-quality, responsive Footer widget matching the HTML and design screenshot.
class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final List<TapGestureRecognizer> _recognizers = [];

  TapGestureRecognizer _createRecognizer(VoidCallback onTap) {
    final recognizer = TapGestureRecognizer()..onTap = onTap;
    _recognizers.add(recognizer);
    return recognizer;
  }

  void _clearRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  void dispose() {
    _clearRecognizers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Clear previous build's gesture recognizers to prevent memory leaks
    _clearRecognizers();

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F7F5), // HTML/CSS background: off-white #F8F7F5
      padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Top Divider (black/10 -> Color(0x1A000000))
          const Divider(height: 1, thickness: 1, color: Color(0x1A000000)),
          const SizedBox(height: 32),

          // 2. Top Poets Section (px-2 equivalent margin -> horizontal 8 padding)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const FooterSectionTitle('TOP POETS'),
                const SizedBox(height: 12),
                _buildPoetsWrap(context),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // 3. Communities Section (px-2 equivalent margin -> horizontal 8 padding)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const FooterSectionTitle('COMMUNITIES'),
                const SizedBox(height: 12),
                _buildCommunitiesWrap(context),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // 4. Advertisement Card
          AdvertiseCard(
            onTap: () {
              debugPrint('Advertise Card clicked: Get in touch');
            },
          ),

          // 5. Middle Divider (black/10 -> Color(0x1A000000))
          const SizedBox(height: 40),
          const Divider(height: 1, thickness: 1, color: Color(0x1A000000)),
          const SizedBox(height: 32),

          // 6. Navigation Grid (READ, EXPLORE, MORE)
          _buildNavigationGrid(context),

          // 7. Bottom Divider (black/10 -> Color(0x1A000000))
          const SizedBox(height: 40),
          const Divider(height: 1, thickness: 1, color: Color(0x1A000000)),
          const SizedBox(height: 20),

          // 8. Branding & Privacy/Terms Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              SvgPicture.asset(
                AppAssets.poetisticLogo,
                width: 72,
                height: 22,
                placeholderBuilder: (context) => const Text(
                  'Poetistic',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A1614),
                  ),
                ),
              ),
              // Privacy & Terms
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FooterLink(
                    label: 'PRIVACY',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6B7280),
                    letterSpacing: 1.2,
                    onTap: () {
                      debugPrint('Privacy Policy clicked');
                    },
                  ),
                  const SizedBox(width: 20), // gap-5 is 20px
                  FooterLink(
                    label: 'TERMS',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6B7280),
                    letterSpacing: 1.2,
                    onTap: () {
                      debugPrint('Terms & Conditions clicked');
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 9. Copyright / Entity Info
          _buildCopyrightText(context),
        ],
      ),
    );
  }

  Widget _buildArrowIcon(Color color, {double size = 14.0}) {
    return SvgPicture.string(
      '''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M1.5 7H12.5M12.5 7L7.5 2M12.5 7L7.5 12" stroke="#1A1614" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  Widget _buildPoetsWrap(BuildContext context) {
    final List<String> poets = [
      'Mirza Ghalib',
      'Jaun Elia',
      'Faiz Ahmad Faiz',
      'Allama Iqbal',
      'Meer Taqi Meer',
      'Sahir Ludhianvi',
      'Gulzar',
      'Javed Akhtar',
      'Waseem Barelvi',
      'Bashir Badr',
      'Akbar Allahabadi',
      'Tehzeeb Hafi',
      'Hasrat Jaipuri',
      'Kaifi Azmi',
      'Mehshar Afridi',
    ];

    final List<InlineSpan> spans = [];
    for (int i = 0; i < poets.length; i++) {
      final poet = poets[i];
      final formattedPoet = poet.replaceAll(' ', '\u00A0');

      spans.add(
        TextSpan(
          text: formattedPoet,
          style: const TextStyle(
            color: Color(0xD91A1614), // text-[#1a1614]/85
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 2.0, // leading-7 (28px / 14px)
          ),
          recognizer: _createRecognizer(() {
            debugPrint('Poet clicked: $poet');
          }),
        ),
      );

      if (i < poets.length - 1) {
        spans.add(
          const TextSpan(
            text:
                '\u00A0· ', // Non-breaking space before dot, regular space after to wrap
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              height: 2.0,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(children: spans),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4.0), // little padding from left
          child: GestureDetector(
            onTap: () {
              debugPrint('All poets clicked');
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'All\u00A0',
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF1A1614),
                      decorationThickness: 1.0,
                      shadows: const [
                        Shadow(
                          color: Color(0xFF1A1614),
                          offset: Offset(0, -2.0),
                        ),
                      ],
                    ),
                  ),
                  TextSpan(
                    text: 'poets\u00A0→',
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF1A1614),
                      decorationThickness: 1.0,
                      shadows: const [
                        Shadow(
                          color: Color(0xFF1A1614),
                          offset: Offset(0, -2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunitiesWrap(BuildContext context) {
    final List<String> cities = [
      'Mumbai',
      'Delhi',
      'Lucknow',
      'Hyderabad',
      'Bengaluru',
      'Pune',
      'Jaipur',
      'Kolkata',
      'Indore',
      'Lahore',
      'Karachi',
    ];

    final List<InlineSpan> spans = [];
    for (int i = 0; i < cities.length; i++) {
      final city = cities[i];
      final formattedCity = city.replaceAll(' ', '\u00A0');

      spans.add(
        TextSpan(
          text: formattedCity,
          style: const TextStyle(
            color: Color(0xD91A1614),
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 2.0,
          ),
          recognizer: _createRecognizer(() {
            debugPrint('Community clicked: $city');
          }),
        ),
      );

      if (i < cities.length - 1) {
        spans.add(
          const TextSpan(
            text: '\u00A0· ',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              height: 2.0,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text.rich(
            TextSpan(children: spans),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4.0), // little padding from left
          child: GestureDetector(
            onTap: () {
              debugPrint('All communities clicked');
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'All\u00A0communities\u00A0→',
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF1A1614),
                      decorationThickness: 1.0,
                      shadows: const [
                        Shadow(
                          color: Color(0xFF1A1614),
                          offset: Offset(0, -2.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FooterMenuColumn(
            title: 'READ',
            items: [
              {
                'label': 'Sher',
                'onTap': () => debugPrint('Menu clicked: Sher'),
              },
              {
                'label': 'Ghazal',
                'onTap': () => debugPrint('Menu clicked: Ghazal'),
              },
              {
                'label': 'Nazm',
                'onTap': () => debugPrint('Menu clicked: Nazm'),
              },
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FooterMenuColumn(
            title: 'EXPLORE',
            items: [
              {
                'label': 'Misra-Kari',
                'onTap': () => debugPrint('Menu clicked: Misra-Kari'),
              },
              {
                'label': 'Festivals',
                'onTap': () => debugPrint('Menu clicked: Festivals'),
              },
              {
                'label': 'Moods',
                'onTap': () => debugPrint('Menu clicked: Moods'),
              },
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FooterMenuColumn(
            title: 'MORE',
            items: [
              {
                'label': 'Listen',
                'onTap': () => debugPrint('Menu clicked: Listen'),
              },
              {
                'label': 'Store',
                'onTap': () => debugPrint('Menu clicked: Store'),
              },
              {
                'label': 'Blog',
                'onTap': () => debugPrint('Menu clicked: Blog'),
              },
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyrightText(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Forged with love in India by ',
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF6B7280),
          height: 1.625, // leading-relaxed (1.625)
        ),
        children: [
          TextSpan(
            text: 'Team\u00A0Poetistic',
            style: const TextStyle(
              color: Colors.transparent,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF111111),
              decorationThickness: 1.0,
              shadows: [
                Shadow(
                  color: Color(0xFF111111),
                  offset: Offset(0, -1.5), // Offset adjusted for 12px font size
                ),
              ],
            ),
            recognizer: _createRecognizer(() {
              debugPrint('Branding Link clicked: Team Poetistic');
            }),
          ),
          const TextSpan(
            text: ' · An entity of Voidwave Labs Pvt. Ltd. © 2026',
          ),
        ],
      ),
    );
  }
}

/// A header label for section groupings.
class FooterSectionTitle extends StatelessWidget {
  final String title;

  const FooterSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: Color(0xFF6B7280), // #6B7280
      ),
    );
  }
}

/// A clickable link layout widget with hover/underline capabilities.
class FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool underline;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final double? height;

  const FooterLink({
    required this.label,
    required this.onTap,
    this.underline = false,
    this.color = const Color(0xFF374151),
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.letterSpacing,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height ?? 1.8,
          letterSpacing: letterSpacing,
          decoration: underline
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: color,
        ),
      ),
    );
  }
}

/// A responsive column widget displaying a group of footer items.
class FooterMenuColumn extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const FooterMenuColumn({required this.title, required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FooterSectionTitle(title),
        const SizedBox(height: 12),
        ...items
            .expand(
              (item) => [
                FooterLink(
                  label: item['label'] as String,
                  onTap: item['onTap'] as VoidCallback,
                  color: const Color(0xFF1A1614),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.5,
                ),
                const SizedBox(height: 8),
              ],
            )
            .toList()
          ..removeLast(),
      ],
    );
  }
}

/// Rounded advertisement card matching the screenshot.
class AdvertiseCard extends StatelessWidget {
  final VoidCallback onTap;

  const AdvertiseCard({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x1A000000), width: 1.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Advertise with Poetistic',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A1614),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Reach poetry lovers across India',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Get in touch',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1614),
                  ),
                ),
                const SizedBox(width: 4),
                SvgPicture.string(
                  '''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M1.5 7H12.5M12.5 7L7.5 2M12.5 7L7.5 12" stroke="#1A1614" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''',
                  width: 14,
                  height: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
