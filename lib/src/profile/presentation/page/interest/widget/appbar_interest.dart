import 'package:flutter/material.dart';

import '../../../../../../core/components/text/blue_gradient_text.dart';

class AppBarInterest extends StatelessWidget implements PreferredSizeWidget {
  const AppBarInterest({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 84,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 24,
              ),
              Text(
                "Back",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 26.0, top: 10),
          child: BlueText(text: 'Save'),
        )
      ],
    );
  }
}
