import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/styles/colors.dart';

void main() {
  test('Green gradient should have 3 colors', () {
    expect(YouAppColors.greenGradient.length, 3);
  });

  test('Gold gradient should have 7 colors', () {
    expect(YouAppColors.goldGradient.length, 7);
  });

  test('Black doff should be Color(0xFF09141A)', () {
    expect(YouAppColors.blackDoff, const Color(0xFF09141A));
  });

  test('Blue gradient should have 2 colors', () {
    expect(YouAppColors.blueGradient.length, 2);
  });

  test('Color gold should be Color(0xFFDCB464)', () {
    expect(YouAppColors.colorGold, const Color(0xFFDCB464));
  });
}
