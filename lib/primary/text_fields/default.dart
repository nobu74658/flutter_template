import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    this.controller,
    this.circularRadius,
    this.hintText,
    this.title,
    this.titleStyle,
    this.maxLength,
    this.maxLines = 1,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.minLines,
    this.backgroundColor,
    this.isNumberOnly = false,
    this.isCounterTextBehind = true,
    this.isMin = false,
    this.isUnderline = false,
    this.readOnly = false,
    this.isBorder = true,
    this.hintStyle,
    this.textStyle,
    super.key,
  });

  final TextEditingController? controller;
  final double? circularRadius;
  final String? title;
  final String? hintText;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final bool isNumberOnly;
  final bool isCounterTextBehind;
  final bool isMin;
  final bool isUnderline;
  final bool readOnly;
  final bool isBorder;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = isUnderline
        ? const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(circularRadius ?? 8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.grey,
            ),
          );

    return Column(
      mainAxisSize: isMin ? MainAxisSize.min : MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title!,
              style: titleStyle ??
                  const TextStyle(
                    fontSize: 14,
                  ),
            ),
          ),
        TextField(
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,
          controller: controller,
          obscureText: obscureText,
          keyboardType: isNumberOnly ? TextInputType.number : keyboardType,
          inputFormatters: isNumberOnly
              ? [FilteringTextInputFormatter.digitsOnly]
              : inputFormatters,
          style: isUnderline
              ? textStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )
              : textStyle,
          readOnly: readOnly,
          onTapOutside: (event) => primaryFocus?.unfocus(),
          decoration: InputDecoration(
            fillColor: backgroundColor,
            filled: backgroundColor != null,
            suffixIconConstraints: const BoxConstraints(maxHeight: 20),
            suffixIcon: suffixIcon,
            counterText: isCounterTextBehind ? '' : null,
            hintStyle: hintStyle ??
                const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
            hintText: hintText,
            enabledBorder: isBorder ? outlineInputBorder : InputBorder.none,
            focusedBorder: isBorder ? outlineInputBorder : InputBorder.none,
          ),
        ),
      ],
    );
  }
}
