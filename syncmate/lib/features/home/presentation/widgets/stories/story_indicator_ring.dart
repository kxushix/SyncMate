import 'package:flutter/material.dart';

/// A reusable circular ring indicating story status.
///
/// - Unviewed: vibrant gradient ring (Instagram-style) by default, or a
///   pastel solid color ring when [ringColor] is provided.
/// - Viewed: subtle grey ring.
class StoryIndicatorRing extends StatelessWidget {
  final bool isViewed;
  final Widget child;

  /// Optional pastel color for the ring border (per-author color from HTML).
  /// If null and [isViewed] is false, falls back to gradient.
  final Color? ringColor;

  /// Space between the ring border and the inner white gap container.
  final double padding;

  const StoryIndicatorRing({
    super.key,
    required this.isViewed,
    required this.child,
    this.ringColor,
    this.padding = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    // Determine ring decoration
    BoxDecoration ringDecoration;
    if (isViewed) {
      ringDecoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD1D1D1),
          width: 2,
        ),
      );
    } else if (ringColor != null) {
      // Pastel solid color ring (per-author style)
      ringDecoration = BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ringColor!,
          width: 2,
        ),
      );
    } else {
      // Gradient ring (default unviewed)
      ringDecoration = const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFFBAA47), // Orange
            Color(0xFFD91A46), // Pink/Red
            Color(0xFFA60F93), // Purple
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: ringDecoration,
      child: Container(
        // White gap between ring and avatar (like HTML's `p-1` inner pad)
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F4F0), // Match app background
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
