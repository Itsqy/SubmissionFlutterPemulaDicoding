import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helloflutter/screen/main_screen.dart';

void main() {
  group('test main screen widget', () {
    testWidgets('find user textfield and fill the textfield',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: MainScreen(),
      ));
      var textField = find.byKey(const Key('textFieldUser'));
      await widgetTester.enterText(textField, 'Muhammad Rifqi Syatria');
      expect(find.text('Muhammad Rifqi Syatria'), findsOneWidget);
    });
    testWidgets('find button and tap', (widgetTester) async {
      await widgetTester.pumpWidget(const MaterialApp(
        home: MainScreen(),
      ));
      var button = find.byType(ElevatedButton);
      expect(button, findsOneWidget);
      await widgetTester.tap(button);
    });
  });
}
