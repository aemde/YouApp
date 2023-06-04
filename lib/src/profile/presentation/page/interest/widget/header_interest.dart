import 'package:flutter/material.dart';
import 'package:youapp_test/core/styles/colors.dart';

class HeaderInterest extends StatelessWidget {
  const HeaderInterest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: YouAppColors.goldGradient,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ).createShader(bounds);
            },
            child: const Text(
              "Tell everyone about yourself",
              style: TextStyle(
                fontSize: 18.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "What interest you?",
          style: TextStyle(
            fontSize: 24.2,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
