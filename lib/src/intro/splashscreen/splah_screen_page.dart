import 'package:flutter/material.dart';

import '../../../core/components/container.dart';
import '../../../core/components/text/golden_gradient_text.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: containerGradient(context, body()));
  }

  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/icon.png'),
          const GoldText(
            text: 'by : Ahmad Mursyidi',
            fontSize: 17.5,
          )
        ],
      ),
    );
  }
}
