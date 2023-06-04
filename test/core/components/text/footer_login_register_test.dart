import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/components/text/footer_login_register.dart';

void main() {
  group('FooterLoginRegister', () {
    late VoidCallback mockOnTap;
    late Widget widget;

    setUp(() {
      mockOnTap = () {};
      widget = MaterialApp(
        home: Material(
          child: FooterLoginRegister(
            firstText: 'First',
            secondText: 'Second',
            onTap: mockOnTap,
          ),
        ),
      );
    });

    testWidgets('Should display correct first and second text',
        (WidgetTester tester) async {
      await tester.pumpWidget(widget);

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsOneWidget);
    });

    testWidgets('Should call onTap callback when tapped on second text',
        (WidgetTester tester) async {
      bool onTapCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: FooterLoginRegister(
              firstText: 'First',
              secondText: 'Second',
              onTap: () {
                onTapCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Second'));
      await tester.pump();

      expect(onTapCalled, true);
    });
  });
}
