import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:my_app/pages/create_event_page.dart';

void main() {
  testWidgets('Test CreateEventPage with good data',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateEventPage()));
    final sportDropdown = find.text('Select a sport using the dropdown below:');
    final skillDropdown =
        find.text('select a skill level using the dropdown below:');
    final addressField =
        find.widgetWithText(TextFormField, 'Choose a Location');
    final dateButton =
        find.widgetWithIcon(FloatingActionButton, Icons.calendar_today_rounded);
    final timeButton =
        find.widgetWithIcon(FloatingActionButton, Icons.access_time);
    final durationField =
        find.widgetWithText(TextFormField, 'Enter the Duration');
    final descriptionField =
        find.widgetWithText(TextFormField, 'Add a description');

    // Verify initial state of input menu
    expect(sportDropdown, findsOneWidget);
    expect(skillDropdown, findsOneWidget);
    expect(addressField, findsOneWidget);
    expect(dateButton, findsOneWidget);
    expect(timeButton, findsOneWidget);
    expect(durationField, findsOneWidget);
    expect(descriptionField, findsOneWidget);

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

    // Enter text into the Address textbox
    await tester.enterText(addressField, 'Long Leaf Park');

    // Verify Address textbox was updated
    expect(find.text('Long Leaf Park'), findsOneWidget);

    // Tap the date button and wait for the dialog to appear
    await tester.tap(dateButton);
    await tester.pumpAndSettle();

    // Find the dialog and the "OK" button
    final dialog = find.byType(Dialog);
    final okButton = find.widgetWithText(TextButton, 'OK');
    expect(dialog, findsOneWidget);
    expect(okButton, findsOneWidget);

    // Pick a date and tap the "OK" button
    final date = DateTime(2022, 5, 1);
    final formattedDate = DateFormat.yMd().format(date);
    await tester.tap(find.text(formattedDate));
    await tester.tap(okButton);
    await tester.pumpAndSettle();

    // Verify that the date was updated in the UI
    final dateText = find.text(formattedDate);
    expect(dateText, findsOneWidget);

    // Tap the time button and wait for the dialog to appear
    await tester.tap(timeButton);
    await tester.pumpAndSettle();

    // Find the dialog and the "OK" button
    final dialog2 = find.byType(Dialog);
    final okButton2 = find.widgetWithText(TextButton, 'OK');
    expect(dialog2, findsOneWidget);
    expect(okButton2, findsOneWidget);

    // Pick a time and tap the "OK" button
    final time = TimeOfDay(hour: 14, minute: 30);
    final formattedTime =
        DateFormat.jm().format(DateTime(2022, 1, 1, time.hour, time.minute));
    await tester.tap(find.text(formattedTime));
    await tester.tap(okButton2);
    await tester.pumpAndSettle();

    // Verify that the time was updated in the UI
    final timeText = find.text(formattedTime);
    expect(timeText, findsOneWidget);

    // Enter text into the Address textbox
    await tester.enterText(durationField, '2 Hours');

    // Verify Address textbox was updated
    expect(find.text('2 Hours'), findsOneWidget);

    // Enter text into the Address textbox
    await tester.enterText(descriptionField, '4v4 soccer game, need 2 more');

    // Verify Address textbox was updated
    expect(find.text('4v4 soccer game, need 2 more'), findsOneWidget);
  });
}
