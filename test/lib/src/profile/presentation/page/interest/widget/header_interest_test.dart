import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/src/profile/presentation/page/interest/widget/header_interest.dart';

void main() {
  testWidgets('HeaderInterest displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HeaderInterest(),
        ),
      ),
    );

    // Verify the presence of the "Tell everyone about yourself" text
    expect(
      find.text("Tell everyone about yourself"),
      findsOneWidget,
    );

    // Verify the presence of the "What interest you?" text
    expect(
      find.text("What interest you?"),
      findsOneWidget,
    );

    // Verify the presence of the gradient shader
    expect(
      find.descendant(
        of: find.byType(ShaderMask),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });
}
