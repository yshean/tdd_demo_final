// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/empty_placeholder.dart';

import 'package:tdd_demo/startup_name_list.dart';

Widget wrapInApp(Widget widget) => MaterialApp(home: widget);

void main() {
  // NOTE: Step 1 - Check the UI design, find what are the requirements
  testWidgets('Should show the title in app bar', (WidgetTester tester) async {
    // Step 2 - Write your first test - it should fail because it cannot find the StartupNameList
    // Step 7 - Uh oh, compilation failed because it does not have a MaterialApp widget - we shall wrap it with MaterialApp
    // Step 8 - After wrapInApp, the test should pass
    // await tester.pumpWidget(StartupNameList());
    await tester.pumpWidget(wrapInApp(StartupNameList()));
    // Step 4 - Run the test again - the test should pass

    // Step 5- Write another line of the test - until it fails again
    expect(
        find.widgetWithText(AppBar, 'Startup Name Generator'), findsOneWidget);
  });

  // Step 9 - Continue with another test
  // Hmm what can we test?
  // Showing the entries - what are the input and output?
  // Show empty placeholder when nothing
  // Input: arguments to the widget, Output: display the tiles for each entry
  // How to create code snippets on VS Code - shift+cmd+P - Preferences: Open User Snippets - dart
  group('Display entries correctly', () {
    testWidgets('Show empty placeholder when there is no entry',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInApp(StartupNameList(entries: [])));

      // Step 10: Add more test until it fails
      // Compilation failure is also counted
      expect(find.byType(EmptyPlaceholder), findsOneWidget);
      // Step 14: Run the test again - it passes
      // Stop here and proceed to the next test

      // Extra test
      expect(tester.widgetList(find.byType(ListTile)).length, 0);
    });

    testWidgets('Show a tile for each entry', (WidgetTester tester) async {
      // Step 15: Let's start with one entry
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1'],
      )));

      // Step 15: The test should fail
      expect(find.widgetWithText(ListTile, 'Name 1'), findsOneWidget);

      // Step 17: Now the test should pass, let's continue with two entries
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1', 'Name 2'],
      )));

      expect(find.widgetWithText(ListTile, 'Name 1'), findsOneWidget);
      // Step 18: Now the test should fail again, because it cannot find 'Name 2'
      expect(find.widgetWithText(ListTile, 'Name 2'), findsOneWidget);
      // Step 19: Now the test should pass again, let's continue with the next test

      // Extra test
      expect(tester.widgetList(find.byType(ListTile)).length, 2);
    });

    testWidgets('Show an icon for each tile', (WidgetTester tester) async {
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1'],
      )));

      // Step 20: The test should fail
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 1'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);

      // Step 22: Now test should pass, let's continue with two entries
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1', 'Name 2'],
      )));

      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 1'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 2'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);
    });
  });

  // Step 23 - Write test for favourite icon
  group('The favourite icon should work correctly', () {
    testWidgets(
        'When tap on the favourite icon and currently outlined, it should switch to filled and colour should be red',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1', 'Name 2'],
      )));

      // Check initial state
      final iconFinder = find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite_outline));
      expect(iconFinder, findsOneWidget);
      expect((tester.widget(iconFinder) as Icon).color, null);
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 2'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);

      // Still Step 23
      await tester.tap(find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite_outline)));
      await tester.pumpAndSettle();

      // Now it should be filled
      // Step 23: Now the test should fail
      final favoriteIconFinder = find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite));
      expect(favoriteIconFinder, findsOneWidget);
      expect((tester.widget(favoriteIconFinder) as Icon).color, Colors.red);
      // Step 25: Now the test should pass
      // Now we should also check if the second entry is unaffected
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 2'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);
      // It should pass, now we can proceed to write the next test
    });

    // Step 27: Now check the other way round if it works
    testWidgets(
        'When tap on the favourite icon and currently filled, it should switch to outlined',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1', 'Name 2'],
      )));

      // Setup: Let's tap them until we see favorite icon
      await tester.tap(find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite_outline)));
      await tester.pumpAndSettle();
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 1'),
              matching: find.byIcon(Icons.favorite)),
          findsOneWidget);

      // Still Step 27
      await tester.tap(find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite)));
      await tester.pumpAndSettle();

      // Step 27: Now the test should fail
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 1'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);
      expect(
          find.descendant(
              of: find.widgetWithText(ListTile, 'Name 2'),
              matching: find.byIcon(Icons.favorite_outline)),
          findsOneWidget);
      // Step 28: Now the test should pass ☑
      // Extra: Sometimes you only know whether you should add a test once you've written the implementation
      // It is okay to not TDD 100% of the time, e.g. adding color to Icon
    });
  });

  // Subsequent tests: Favourite list should display correctly - Navigate to favourite list, - Add 1, multiple, - Remove 1, multiple
  // Step 29: Now we can write our final group of tests
  group('Saved list should display correctly', () {
    testWidgets(
        'When tap on list icon, it should navigate to the saved list page',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInApp(StartupNameList()));

      // Step 29: The test should fail, because we don't have Icons.list yet
      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();
      // Step 30: Now the test should pass, after we've added in the AppBar

      // Step 31: The test should fail, because we don't have the saved suggestions page yet
      expect(find.widgetWithText(AppBar, 'Saved Suggestions'), findsOneWidget);
      // Step 32: Now the test should pass, we should check that there's nothing here
      expect(find.byType(ListTile), findsNothing);
    });

    // Step 33: Write our second last test
    testWidgets(
        'When tap on favourite icon, the entry should be added to favourites, and can be found on the favourite list page, and vice versa',
        (WidgetTester tester) async {
      await tester.pumpWidget(wrapInApp(StartupNameList(
        entries: ['Name 1', 'Name 2'],
      )));

      await tester.tap(find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite_outline)));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, 'Saved Suggestions'), findsOneWidget);
      // Step 34: This test should fail, because we don't have this in our Saved Suggestions page yet
      expect(
          find.byType(ListTile), findsOneWidget); // should have only one widget
      // We should also check if that list tile has 'Name 1' on it
      expect(find.widgetWithText(ListTile, 'Name 1'), findsOneWidget);
      // Step 35: Now the test shall pass

      // Step 36: Now write the vice versa part
      // When tap on favourite icon when it was already saved, the entry should be removed from favourites, and should not be found on the favourite list page
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      // Check that we're back
      expect(find.widgetWithText(AppBar, 'Startup Name Generator'),
          findsOneWidget);

      await tester.tap(find.descendant(
          of: find.widgetWithText(ListTile, 'Name 1'),
          matching: find.byIcon(Icons.favorite)));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.list));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(AppBar, 'Saved Suggestions'), findsOneWidget);

      expect(find.byType(ListTile), findsNothing);
    });
  });
}
