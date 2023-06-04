import 'package:flutter/material.dart';

import '../../../../../../core/components/textform_field.dart';

class WeightWidget extends StatelessWidget {
  const WeightWidget({
    super.key,
    required this.weightController,
  });

  final TextEditingController weightController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Weight:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.white.withOpacity(0.33),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 202, height: 36),
          child: CustomTextFormField(
            hintText: ("Add weight"),
            controller: weightController,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
