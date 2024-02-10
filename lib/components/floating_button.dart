import '../tools/colors.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color = themeColor,
  });
  final Widget child;
  final Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }
}
