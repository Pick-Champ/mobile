import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class CreateTextButton extends StatelessWidget {
  const CreateTextButton({
    required this.onTap,
    required this.text,
    this.bgColor,
    this.txtColor,
    super.key,
  });
  final VoidCallback onTap;
  final String text;
  final Color? bgColor;
  final Color? txtColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.all<Size>(
            Size(context.screenWidth - 50, 45),
          ),
          maximumSize: WidgetStateProperty.all<Size>(
            Size(context.screenWidth - 50, 45),
          ),
          elevation: WidgetStateProperty.all<double>(1),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
            bgColor ?? context.themeData.disabledColor,
          ),
        ),
        child: Text(
          text,
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: txtColor ?? Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }
}
