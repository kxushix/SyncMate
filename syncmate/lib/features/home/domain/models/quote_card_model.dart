import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'quote_position.dart';

/// Immutable model representing a Quote Card's data and layout configuration.
class QuoteCardModel extends Equatable {
  final String id;
  final String quote;
  final String author;
  final String backgroundImage;
  final QuotePosition position;
  final TextAlign textAlign;
  final double topPercent;
  final double leftPercent;
  final String textColor;
  final int likeCount;
  final bool isLiked;
  final bool isSaved;

  const QuoteCardModel({
    required this.id,
    required this.quote,
    required this.author,
    required this.backgroundImage,
    this.position = QuotePosition.middleCenter,
    this.textAlign = TextAlign.center,
    this.topPercent = 0.34,
    this.leftPercent = 0.5,
    this.textColor = '#FFFFFF',
    this.likeCount = 0,
    this.isLiked = false,
    this.isSaved = false,
  });

  @override
  List<Object?> get props => [
        id,
        quote,
        author,
        backgroundImage,
        position,
        textAlign,
        topPercent,
        leftPercent,
        textColor,
        likeCount,
        isLiked,
        isSaved,
      ];
}
