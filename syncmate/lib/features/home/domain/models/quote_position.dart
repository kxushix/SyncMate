import 'package:flutter/material.dart';

/// Defines the available positions for quote text within a card.
enum QuotePosition {
  topLeft,
  topCenter,
  topRight,
  middleLeft,
  middleCenter,
  middleRight,
  bottomLeft,
  bottomCenter,
  bottomRight;

  /// Maps the enum value to a Flutter [Alignment].
  Alignment get alignment {
    switch (this) {
      case QuotePosition.topLeft: return Alignment.topLeft;
      case QuotePosition.topCenter: return Alignment.topCenter;
      case QuotePosition.topRight: return Alignment.topRight;
      case QuotePosition.middleLeft: return Alignment.centerLeft;
      case QuotePosition.middleCenter: return Alignment.center;
      case QuotePosition.middleRight: return Alignment.centerRight;
      case QuotePosition.bottomLeft: return Alignment.bottomLeft;
      case QuotePosition.bottomCenter: return Alignment.bottomCenter;
      case QuotePosition.bottomRight: return Alignment.bottomRight;
    }
  }
}
