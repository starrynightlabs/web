// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:web/main.dart';

void main() {
  testWidgets('Show text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('We Make Stars!'), findsOneWidget);
    expect(
      find.text('Support your athletes\nEnjoy the missions together.'),
      findsOneWidget,
    );
    expect(find.text('What is NYXS'), findsOneWidget);
    expect(
      find.text(
        'A new web3 sporting platform\nconnecting fans with their\nfavorite athletes.',
      ),
      findsOneWidget,
    );
    expect(find.text('What is Mission'), findsOneWidget);
    expect(find.text('What is Star'), findsOneWidget);
    expect(
      find.text('Make a special experience\nwith your athletes!'),
      findsOneWidget,
    );
    expect(find.text('Launching soon.'), findsOneWidget);
  });
}
