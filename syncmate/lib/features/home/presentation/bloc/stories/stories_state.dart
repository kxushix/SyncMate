import 'package:equatable/equatable.dart';
import '../../../domain/models/poet_story.dart';

abstract class StoriesState extends Equatable {
  const StoriesState();

  @override
  List<Object> get props => [];
}

class StoriesInitial extends StoriesState {}

class StoriesLoaded extends StoriesState {
  final List<PoetStory> stories;
  const StoriesLoaded(this.stories);

  @override
  List<Object> get props => [stories];
}
