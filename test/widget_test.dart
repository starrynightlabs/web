// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:web/main.dart';

void main() {
  testWidgets('Show text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const NyxsWeb());

    expect(find.text('We Make Stars!'), findsOneWidget);
    expect(
      find.text('Support your athletes\nEnjoy the missions together.'),
      findsOneWidget,
    );

    // Because of lazy build of listview, the controller should move the scroll to find widgets
    final listView = tester.widget<ListView>(find.byType(ListView));
    final ctrl = listView.controller;

    ctrl!.jumpTo(ctrl.offset + 1000);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(
      find.text(
        'A new web3 sporting platform\nconnecting fans with their\nfavorite athletes.',
      ),
      findsOneWidget,
    );

    ctrl.jumpTo(ctrl.offset + 2000);

    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('What is Mission'), findsOneWidget);
    // TODO: uncomment
    // expect(find.text('What is Star'), findsOneWidget);

    ctrl.jumpTo(ctrl.offset + 1000);

    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(
      find.text('Make a special experience\nwith your athletes!'),
      findsOneWidget,
    );

    ctrl.jumpTo(ctrl.offset + 500);

    await tester.pumpAndSettle(const Duration(milliseconds: 100));

    expect(find.text('FAQ'), findsOneWidget);
    expect(find.text('Launching soon.'), findsOneWidget);
  });
}
