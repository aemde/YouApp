import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/components/error_dialog.dart';

void main() {
  testWidgets('ErrorDialog should display correct text',
      (WidgetTester tester) async {
    const String errorText = 'An error occurred';

    await tester.pumpWidget(
      const MaterialApp(
        home: Material(
          child: ErrorDialog(text: errorText),
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.text(errorText));
    expect(textWidget, isNotNull);
  });
}
