import 'package:flutter/material.dart';
import 'package:youapp_test/core/styles/colors.dart';

class GoldText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const GoldText({
    Key? key,
    required this.text,
    this.fontSize = 17.2,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: YouAppColors.goldGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
