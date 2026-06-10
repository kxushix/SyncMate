import 'package:equatable/equatable.dart';

abstract class StoriesEvent extends Equatable {
  const StoriesEvent();

  @override
  List<Object> get props => [];
}

/// Event to initialize and load stories from mock data.
class LoadStories extends StoriesEvent {}

/// Event triggered when a story is tapped to update its viewed status.
class MarkStoryAsViewed extends StoriesEvent {
  final String storyId;
  const MarkStoryAsViewed(this.storyId);

  @override
  List<Object> get props => [storyId];
}
