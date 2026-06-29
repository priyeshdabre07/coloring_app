// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:coloring_app/canvas_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Canvas screen builds', (WidgetTester tester) async {
    // Build our canvas screen and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: CanvasScreen()));

    // Verify that the screen builds without error
    expect(find.text('Art Studio'), findsOneWidget);
  });
}
