import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timer/main.dart';

void main() {
  testWidgets('Tapping on button starts timer', (WidgetTester tester) async {
    await tester.pumpWidget(TimerApp());

    expect(find.text('Tap to start'), findsOneWidget);

    final playButton = find.byIcon(Icons.play_arrow);
    expect(playButton, findsOneWidget);

    // Tap the 'play icon' icon and trigger a frame.
    await tester.tap(playButton);
  });
}
