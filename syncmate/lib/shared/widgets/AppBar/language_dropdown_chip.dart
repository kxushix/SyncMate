import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// A functional dropdown chip for language selection.
/// 
/// This widget maintains its own selection state and displays a popup menu
/// with an aesthetic selection style featuring a rounded background shade 
/// with internal padding.
class LanguageDropdownChip extends StatefulWidget {
  const LanguageDropdownChip({super.key});

  @override
  State<LanguageDropdownChip> createState() => _LanguageDropdownChipState();
}

class _LanguageDropdownChipState extends State<LanguageDropdownChip> {
  // Current selection state
  String _selectedLanguage = 'हिन्दी';

  // Available options
  final List<String> _languages = ['हिन्दी', 'English', 'Urdu'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // Position the menu below the chip
      offset: const Offset(0, 30),
      // Styling the menu appearance
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.white,
      elevation: 4,
      onSelected: (String value) {
        setState(() {
          _selectedLanguage = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return _languages.map((String language) {
          final bool isSelected = _selectedLanguage == language;
          
          return PopupMenuItem<String>(
            value: language,
            height: 48,
            // Add slight horizontal padding so the rounded background doesn't touch the menu edges
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                // Rounded background for a more aesthetic look
                color: isSelected ? Colors.black.withValues(alpha: 0.05) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    language,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: AppColors.blackText,
                    ),
                  ),
                  const Spacer(),
                  // Black rounded tick icon for selected option
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.black,
                    ),
                ],
              ),
            ),
          );
        }).toList();
      },
      // The visual chip that triggers the menu
      child: Container(
        height: 24, // HTML: height: 24px
        constraints: const BoxConstraints(minWidth: 44), // HTML: min-width: 44px
        padding: const EdgeInsets.symmetric(horizontal: 10), // HTML: padding: 0 10px
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(9999), // HTML: rounded-full
          border: Border.all(
            color: const Color(0x806E6E6E), // hsla(0,0%,43%,.5)
            width: 0.35, // HTML: border: .35px
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedLanguage.toUpperCase(),
              style: const TextStyle(
                fontSize: 9, // HTML: text-[9px]
                fontWeight: FontWeight.normal,
                color: Color(0xFF111827), // HTML: color: #1c1c1c or #111827
              ),
            ),
            const SizedBox(width: 3), // HTML gap: 3px
            CustomPaint(
              size: const Size(7, 7),
              painter: const ChevronDownPainter(color: Color(0xFF111827)),
            ),
          ],
        ),
      ),
    );
  }
}

/// A CustomPainter that draws a 7x7 pixel downward-pointing chevron.
class ChevronDownPainter extends CustomPainter {
  final Color color;
  const ChevronDownPainter({this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // A clean chevron pointing down in a 7x7 box:
    // Left (1, 2.5) -> Middle Bottom (3.5, 5) -> Right (6, 2.5)
    path.moveTo(1.0, 2.5);
    path.lineTo(3.5, 5.0);
    path.lineTo(6.0, 2.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

