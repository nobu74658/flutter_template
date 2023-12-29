import 'package:app/extensions/context.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.fontSize,
    this.circularRadius,
    this.side,
    this.width,
    this.elevation,
    this.isBold = true,
    this.isBottomNavigationBar = false,
    this.isViewInsetsBottom = false,
    super.key,
  });

  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isBold;
  final double? fontSize;
  final double? circularRadius;
  final double? width;
  final double? elevation;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;

  /// BottomNavigationBar に設置する場合は true にする
  final bool isBottomNavigationBar;
  final bool isViewInsetsBottom;

  @override
  Widget build(BuildContext context) => Padding(
        padding: isBottomNavigationBar
            ? const EdgeInsets.symmetric(horizontal: 18).copyWith(
                top: 8,
                bottom: context.bottomSafeArea +
                    12 +
                    (isViewInsetsBottom
                        ? MediaQuery.of(context).viewInsets.bottom
                        : 0),
              )
            : EdgeInsets.zero,
        child: SizedBox(
          width: width,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: elevation,
              padding: padding ??
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circularRadius ?? 6),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: side,
            ),
            child: child ??
                Text(
                  text ?? 'Error Text',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
          ),
        ),
      );
}
