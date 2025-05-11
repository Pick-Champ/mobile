import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.isDark,
    required this.text,
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;
  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(
          Size(context.screenWidth - 10, 60),
        ),
        maximumSize: WidgetStateProperty.all<Size>(
          Size(context.screenWidth - 10, 60),
        ),
        elevation: WidgetStateProperty.all<double>(0),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          isDark ? Colors.black : Colors.white,
        ),
      ),
      child: Text(
        text,
        style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w900,
          color: isDark ? Colors.white : Colors.black,
        ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
