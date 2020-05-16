import 'package:destini_challenge_starting/story_brain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('story brain returns first story by default', () {
    var story = StoryBrain().getStory();

    expect(story, isNotNull);
  });
  test('story brain returns other story with different storyNumber', () {
    var story = StoryBrain().getStory();
    var otherStory = StoryBrain(storyNumber: 1).getStory();

    expect(story != otherStory, true);
  });
  test('story brain returns choice1', () {
    var choice1 = StoryBrain().getChoice1();

    expect(choice1, isNotNull);
  });
  test('story brain returns choice2', () {
    var choice2 = StoryBrain().getChoice2();

    expect(choice2, isNotNull);
  });
  test('story brain has default number of 0', () {
    var storyNumber = StoryBrain().storyNumber;

    expect(storyNumber, 0);
  });
  test('#reset sets story number back to 0', () {
    StoryBrain brain = StoryBrain().nextStory(1).reset();

    expect(brain.storyNumber, 0);
  });
  group('next story', () {
    StoryBrain brain;
    setUp(() {
      brain = StoryBrain();
    });
    group('story 0', () {
      test('choice 1 -> story 2', () {
        brain.nextStory(1);

        expect(brain.storyNumber, 2);
      });
      test('choice 2 -> story 1', () {
        var brain = StoryBrain();

        brain.nextStory(2);

        expect(brain.storyNumber, 1);
      });
    });
    group('story 1', () {
      setUp(() {
        brain = StoryBrain(storyNumber: 1);
      });
      test('choice 1 -> story 2', () {
        brain.nextStory(1);

        expect(brain.storyNumber, 2);
      });
      test('choice 2 -> story 3', () {
        brain.nextStory(2);

        expect(brain.storyNumber, 3);
      });
    });
    group('story 2', () {
      setUp(() {
        brain = StoryBrain(storyNumber: 2);
      });
      test('choice 1 -> story 5', () {
        brain.nextStory(1);

        expect(brain.storyNumber, 5);
      });
      test('choice 2 -> story 4', () {
        brain.nextStory(2);

        expect(brain.storyNumber, 4);
      });
    });
    group('last story', () {
      test('resets on story 3', () {
        var brain = StoryBrain(storyNumber: 3).nextStory(1);

        expect(brain.storyNumber, 0);
      });
      test('resets on story 4', () {
        var brain = StoryBrain(storyNumber: 4).nextStory(1);

        expect(brain.storyNumber, 0);
      });
      test('resets on story 5', () {
        var brain = StoryBrain(storyNumber: 5).nextStory(1);

        expect(brain.storyNumber, 0);
      });
    });
  });

  group("#buttonShouldBeVisible", () {
    [0, 1, 2].forEach((storyNumber) {
      test('buttons should be visible for stories with arc story $storyNumber',
          () {
        bool visible =
            StoryBrain(storyNumber: storyNumber).buttonsShouldBeVisible();

        expect(visible, isTrue);
      });
    });

    [3, 4, 5].forEach((storyNumber) {
      test(
          'buttons should be hidden for stories without arc story $storyNumber',
          () {
        bool visible =
            StoryBrain(storyNumber: storyNumber).buttonsShouldBeVisible();

        expect(visible, isFalse);
      });
    });
  });
}
