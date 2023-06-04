import 'package:flutter/material.dart';

class BackNavigation extends StatelessWidget {
  const BackNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 83, right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            Text(
              "Back",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
