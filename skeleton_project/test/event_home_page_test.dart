import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/classes/event_class.dart';
import 'package:my_app/pages/event_home_page.dart';
import 'package:my_app/pages/view_event_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  testWidgets('EventHomePage AppBar displays buttons',
      (WidgetTester tester) async {
    // Build the EventHomePage widget
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Verify that the widget shows the 'Add' and 'Filter' buttons in the AppBar
    expect(find.widgetWithIcon(AppBar, Icons.add), findsOneWidget);
    expect(find.widgetWithIcon(AppBar, Icons.arrow_drop_down_rounded),
        findsWidgets);
  });
}
