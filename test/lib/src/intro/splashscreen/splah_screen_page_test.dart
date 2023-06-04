import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/components/text/golden_gradient_text.dart';
import 'package:youapp_test/src/intro/splashscreen/splah_screen_page.dart';

void main() {
  testWidgets('SplashScreenPage Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashScreenPage()));

    // Memeriksa apakah widget Image.asset ditampilkan
    expect(find.byType(Image), findsOneWidget);

    // Memeriksa apakah widget GoldText ditampilkan
    expect(find.byType(GoldText), findsOneWidget);

    // Memeriksa apakah teks 'by : Ahmad Mursyidi' ditampilkan
    expect(find.text('by : Ahmad Mursyidi'), findsOneWidget);

    // Memeriksa apakah ukuran font Text sesuai dengan yang diharapkan
    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style?.fontSize, 17.5);
  });
}
