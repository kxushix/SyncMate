import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

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
      offset: const Offset(0, 34),
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
                color: isSelected ? Colors.black.withOpacity(0.05) : Colors.transparent,
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
        height: 28,
        constraints: const BoxConstraints(minWidth: 48),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.greyText,
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedLanguage,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.blackText,
              ),
            ),
            const SizedBox(width: AppSpacing.s4),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: AppColors.greyText,
            ),
          ],
        ),
      ),
    );
  }
}
