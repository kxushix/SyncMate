import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/stories/stories_bloc.dart';
import '../../bloc/stories/stories_event.dart';
import '../../bloc/stories/stories_state.dart';
import 'story_item.dart';

/// Horizontally scrollable Poet Stories section.
///
/// Layout matches the HTML `homepage-writers-slider`:
/// - Horizontal scroll, snap-center
/// - `px-6` (24px) horizontal padding from screen edges
/// - `my-3` (12px) vertical margin
/// - Height: 107px (64px avatar + 4px ring + 4px gap + 16px text + ~19px breathing room)
class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoriesBloc()..add(LoadStories()),
      child: SizedBox(
        height: 107,
        child: BlocBuilder<StoriesBloc, StoriesState>(
          builder: (context, state) {
            if (state is StoriesLoaded) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                // Matches HTML px-6 = 24px screen horizontal padding
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.stories.length,
                itemBuilder: (context, index) {
                  final story = state.stories[index];
                  return StoryItem(
                    story: story,
                    onTap: () {
                      context
                          .read<StoriesBloc>()
                          .add(MarkStoryAsViewed(story.id));
                    },
                  );
                },
              );
            }
            // Loading/Initial state placeholder
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
