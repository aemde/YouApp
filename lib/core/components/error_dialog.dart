import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'text/golden_gradient_text.dart';

class ErrorDialog extends StatelessWidget {
  final String text;

  const ErrorDialog({
    Key? key,
    required this.text,
  }) : super(
          key: const ValueKey('error_dialog'),
        );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0D1D23),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 5),
            const Center(
              child: GoldText(
                text: "- E r r o r -",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  key: const Key('close_button'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void buildErrorDialog(BuildContext context, String text) {
  showAnimatedDialog(
    alignment: Alignment.center,
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return ErrorDialog(
        key: const ValueKey('error_dialog'),
        text: text,
      );
    },
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 750),
  );
}
