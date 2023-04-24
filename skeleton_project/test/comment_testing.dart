import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:my_app/pages/view_event_page.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  final mockUser = MockUser();
  final mockFirebaseAuth = MockFirebaseAuth();

  setUp(() {
    when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
  });

  group('ViewEvent widget', () {
    testWidgets('should display event details', (WidgetTester tester) async {
      final event = Event(
        'Username',
        'Basketball',
        DateTime.now(),
        '1 hour',
        DateTime.now(),
        '123 Main St',
        'Intermediate',
        'This is a test event',
        [],
      );
      final widget = ViewEvent(currentEventId: 'event_id');

      await tester.pumpWidget(MaterialApp(
        home: widget,
      ));

      // Verify that the event details are displayed on the screen.
      expect(find.text(event.sport), findsOneWidget);
      expect(find.text(event.skill), findsOneWidget);
      expect(find.text(event.address), findsOneWidget);
      expect(find.text(event.description), findsOneWidget);

      // Tap the floating action button to open the modal bottom sheet
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Expect to find the text field to add a comment
      expect(find.byType(TextField), findsOneWidget);

      // Expect to find the stream builder that displays the comments
      expect(find.byType(StreamBuilder), findsOneWidget);

      // Expect to find the floating action button to add a comment
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}

class MockUser extends Mock implements User {}
