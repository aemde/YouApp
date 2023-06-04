import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/src/profile/presentation/page/profile/widget/_height_widget.dart';

void main() {
  late TextEditingController heightController;

  setUp(() {
    heightController = TextEditingController();
  });

  testWidgets('HeightWidget displays correct text and input field',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeightWidget(heightController: heightController),
        ),
      ),
    );

    // Verify the text "Height:" is displayed
    expect(find.text('Height:'), findsOneWidget);

    // Verify the input field is displayed
    expect(find.byType(TextField), findsOneWidget);

    // Enter a value in the input field
    await tester.enterText(find.byType(TextField), '170');
    await tester.pump();

    // Verify the entered value is correctly assigned to the controller
    expect(heightController.text, '170');
  });
}



// I/flutter (14811): 00:00 +0: HeightWidget displays correct text and input field
// W/Parcel  (14811): Expecting binder but got null!
// I/flutter (14811): 00:01 +1: All tests passed!
// D/ProfileInstaller(14811): Installing profile for com.ahmadm.youapp_test