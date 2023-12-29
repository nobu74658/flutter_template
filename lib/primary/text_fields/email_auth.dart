import 'package:flutter/material.dart';

const double _textFieldCircularSize = 8;

class PrimaryEmailAuthTextField extends StatelessWidget {
  const PrimaryEmailAuthTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_textFieldCircularSize),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_textFieldCircularSize),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),

        /// フォーカスを外す
        onTapOutside: (event) => primaryFocus?.unfocus(),
      );
}
