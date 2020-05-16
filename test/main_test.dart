import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';
import '../lib/story_brain.dart';

void main() {
  testWidgets('Destini widget', (WidgetTester tester) async {
    var brain = StoryBrain();
    await tester.pumpWidget(Destini());

    final choice1Text = find.text(brain.getChoice1());
    final choice2Text = find.text(brain.getChoice2());
    final storyTitle = find.text(brain.getStory().title);

    expect(choice1Text, findsOneWidget);
    expect(choice2Text, findsOneWidget);
    expect(storyTitle, findsOneWidget);
  });
  [
    {
      'choices': [1, 1],
      'lastStoryText': 'You bond with the murderer'
    },
    {
      'choices': [1, 2],
      'lastStoryText': 'As you smash through the guardrail and careen towards'
    },
    {
      'choices': [2, 1, 1],
      'lastStoryText': 'You bond with the murderer'
    },
    {
      'choices': [2, 2],
      'lastStoryText': 'What? Such a cop out!'
    },
    {
      'choices': [2, 1, 2],
      'lastStoryText': 'As you smash through the guardrail and careen towards'
    },
  ].forEach((storyArc) {
    testWidgets('story arc $storyArc', (WidgetTester tester) async {
      await tester.pumpWidget(Destini());
      List<int> choices = storyArc['choices'];

      for (var choice in choices) {
        await tester.tap(find.byKey(
          Key('choice$choice'),
        ));
        await tester.pumpAndSettle();
      }
      await tester.pumpAndSettle();

      var storyTitle = find.byKey(Key('storyTitle'));

      expect(storyTitle, findsOneWidget);
      print("story finder ${storyTitle.toString()}");
      var storyTitleText =
          find.descendant(of: storyTitle, matching: find.byType(Text));

      expect(storyTitleText, findsOneWidget);
      Text titleText = tester.firstWidget(storyTitleText);
      expect(titleText.data, contains(storyArc['lastStoryText']));
    });
  });
}
