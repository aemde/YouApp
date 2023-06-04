import 'package:flutter/material.dart';

import '../../../../../../core/components/textform_field.dart';

class HeightWidget extends StatelessWidget {
  const HeightWidget({
    super.key,
    required this.heightController,
  });

  final TextEditingController heightController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Height:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.white.withOpacity(0.33),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 202, height: 36),
          child: CustomTextFormField(
            hintText: ("Add height"),
            controller: heightController,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
