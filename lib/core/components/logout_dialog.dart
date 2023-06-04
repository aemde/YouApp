import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:youapp_test/core/components/text/blue_gradient_text.dart';

import '../platform/key_local_storage.dart';
import '../routes/app_routes.dart';
import 'text/golden_gradient_text.dart';

void logoutDialog(BuildContext context) {
  showAnimatedDialog(
    alignment: Alignment.center,
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => Dialog(
      backgroundColor: const Color(0xFF0D1D23),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 5),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Logout ',
                    style: TextStyle(
                      letterSpacing: 1.1,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    )),
                GoldText(
                    text: "YouApp", fontSize: 17, fontWeight: FontWeight.w600),
              ],
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Are you sure you want to logout ?',
                style: TextStyle(
                  fontSize: 14.5,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      await KeyLocalStorage().deleteAuthStorage('email');
                      Get.offAllNamed(AppRoutes.splash);
                    },
                    child: const BlueText(text: 'Logout')),
              ],
            ),
          ],
        ),
      ),
    ),
    animationType: DialogTransitionType.scale,
    curve: Curves.fastOutSlowIn,
    duration: const Duration(milliseconds: 750),
  );
}
