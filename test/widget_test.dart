// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:web/main.dart';

void main() {
  testWidgets('Show text and contact email', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('Launching soon ⚡'), findsOneWidget);
    expect(find.text('contact@snlabs.io'), findsOneWidget);
  });

  test('getLogoContainerSize', () {
    for (var row in const [
      [Size(1920, 1080), Size(1920, 1080)],
      [Size(1280, 1024), Size(1280, 1024)],
      [Size(400, 920), Size(400, 554)],
      [Size(390, 850), Size(390, 542.5)],
      [Size(375, 670), Size(375, 529)],
    ]) {
      var input = row[0];
      var expected = row[1];

      var ret = MyHomePage.getLogoContainerSize(input);

      var inputString = 'Input: $input';
      expect(ret.width, expected.width, reason: inputString);
      expect(ret.height, expected.height, reason: inputString);
      expect(ret, expected, reason: inputString);
    }
  });
}
