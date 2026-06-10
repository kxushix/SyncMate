import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../domain/models/poet_story.dart';

/// Mock data provider for Poet Stories.
///
/// Each story includes a per-author pastel ring color matching the HTML
/// design reference (border colors from the `homepage-writers-slider`).
class MockStoriesData {
  /// Pastel ring colors extracted from the HTML design (per writer).
  static const List<Color> _ringColors = [
    Color(0xFFE0F7FA), // Cyan tint
    Color(0xFFF3E5F5), // Lavender
    Color(0xFFFFEBEE), // Rose
    Color(0xFFFFF9C4), // Yellow
    Color(0xFFFFEFD5), // Peach
    Color(0xFFE3F2FD), // Light blue
    Color(0xFFFFCDD2), // Soft red
    Color(0xFFF5E6FA), // Soft purple
    Color(0xFFFFE0B2), // Orange
    Color(0xFFE8F5E9), // Mint
  ];

  static List<PoetStory> getStories() {
    final baseStories = [
      PoetStory(
        id: '1',
        name: 'John Keats',
        imageUrl: AppAssets.poet1,
        ringColor: _ringColors[0],
      ),
      PoetStory(
        id: '2',
        name: 'Rumi',
        imageUrl: AppAssets.poet2,
        ringColor: _ringColors[1],
      ),
      PoetStory(
        id: '3',
        name: 'Maya Angelou',
        imageUrl: AppAssets.poet3,
        ringColor: _ringColors[2],
      ),
      PoetStory(
        id: '4',
        name: 'Sylvia Plath',
        imageUrl: AppAssets.poet4,
        ringColor: _ringColors[3],
      ),
      PoetStory(
        id: '5',
        name: 'Robert Frost',
        imageUrl: AppAssets.poet5,
        ringColor: _ringColors[4],
      ),
    ];

    // Repeat with new IDs and additional ring colors for scrolling simulation
    return [
      ...baseStories,
      ...baseStories.asMap().entries.map(
            (e) => e.value.copyWith(
              id: '${e.value.id}_copy',
              ringColor: _ringColors[(e.key + 5) % _ringColors.length],
            ),
          ),
    ];
  }
}
