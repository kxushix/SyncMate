import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable model representing a Poet's story item.
///
/// Uses [Equatable] for efficient BLoC state updates and comparison.
/// [ringColor] is an optional per-author pastel color matching the HTML design.
class PoetStory extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final bool isViewed;

  /// Optional per-author pastel ring color (matches HTML `border-color` per writer).
  /// If null and not viewed, falls back to a gradient ring.
  final Color? ringColor;

  const PoetStory({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isViewed = false,
    this.ringColor,
  });

  /// Creates a copy of [PoetStory] with updated fields.
  PoetStory copyWith({
    String? id,
    String? name,
    String? imageUrl,
    bool? isViewed,
    Color? ringColor,
  }) {
    return PoetStory(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isViewed: isViewed ?? this.isViewed,
      ringColor: ringColor ?? this.ringColor,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, isViewed, ringColor];
}
