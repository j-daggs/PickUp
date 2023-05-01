import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:my_app/pages/event_home_page.dart';

void main() {
  testWidgets('Test EventHomePage', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    final sportDropdown = find.text('All Sports');
    final skillDropdown = find.text('All Skill Levels');
    // Verify initial state of input menu
    expect(sportDropdown, findsOneWidget);
    expect(skillDropdown, findsOneWidget);

    // Open sport dropdown menu
    await tester.tap(find.descendant(
        of: find.byType(DropdownButton), matching: sportDropdown));
    await tester.pumpAndSettle();

    // Select 'Soccer' from sport dropdown menu
    await tester.tap(find.text('Soccer').last);
    await tester.pumpAndSettle();

    // Verify sport dropdown menu was updated
    expect(find.text('Soccer'), findsOneWidget);

    // Open skill level dropdown menu
    await tester.tap(find.descendant(
        of: find.byType(DropdownButton), matching: skillDropdown));
    await tester.pumpAndSettle();

    // Select 'Intermediate' from skill level dropdown menu
    await tester.tap(find.text('Intermediate').last);
    await tester.pumpAndSettle();

    // Verify skill level dropdown menu was updated
    expect(find.text('Intermediate'), findsOneWidget);

    // Verify that an event is found by the address
    expect(find.text('Nature Park'), findsOneWidget);
  });
}
