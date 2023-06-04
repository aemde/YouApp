import 'package:flutter/material.dart';
import 'package:youapp_test/core/styles/colors.dart';

Widget containerGradient(BuildContext context, Widget body) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: YouAppColors.greenGradient)),
    child: body,
  );
}

Widget containerAbout({Widget? child}) {
  return Container(
    alignment: Alignment.centerRight,
    decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 217, 217, 0.06),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.22)),
        borderRadius: BorderRadius.circular(9)),
    child: child,
  );
}
