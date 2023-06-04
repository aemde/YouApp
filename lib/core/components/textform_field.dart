import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(255, 255, 255, 0.22),
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        filled: true,
        fillColor: const Color.fromRGBO(217, 217, 217, 0.06),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 0.3),
          fontSize: 13,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
