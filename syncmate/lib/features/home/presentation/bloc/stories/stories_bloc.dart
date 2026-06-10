import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/mock_stories_data.dart';
import 'stories_event.dart';
import 'stories_state.dart';

/// BLoC managing the state of Poet Stories.
/// 
/// Handles loading and reactive updates of the 'viewed' status.
class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  StoriesBloc() : super(StoriesInitial()) {
    // Initialize stories
    on<LoadStories>((event, emit) {
      final stories = MockStoriesData.getStories();
      emit(StoriesLoaded(stories));
    });

    // Handle view status update
    on<MarkStoryAsViewed>((event, emit) {
      final currentState = state;
      if (currentState is StoriesLoaded) {
        final updatedStories = currentState.stories.map((story) {
          if (story.id == event.storyId) {
            return story.copyWith(isViewed: true);
          }
          return story;
        }).toList();
        
        emit(StoriesLoaded(updatedStories));
      }
    });
  }
}
