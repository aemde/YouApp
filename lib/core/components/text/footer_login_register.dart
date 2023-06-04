import 'package:flutter/material.dart';

import 'golden_gradient_text.dart';

class FooterLoginRegister extends StatelessWidget {
  const FooterLoginRegister({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  }) : super(key: key);

  final String firstText;
  final String secondText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onTap,
          child: GoldText(
            text: secondText,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
