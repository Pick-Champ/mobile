import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/const/padding_insets.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.hintText,
    required this.iconData,
    super.key,
    this.onIconButtonPressed,
    this.keyboardType,
  });
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onIconButtonPressed;
  final IconData iconData;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.brightness == Brightness.dark;
    return Padding(
      padding: PaddingInsets().large,
      child: TextFormField(
        style: context.themeData.textTheme.labelMedium,
        keyboardType: keyboardType,
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: onIconButtonPressed,
            icon: Icon(iconData, color: context.themeData.indicatorColor),
          ),
          fillColor:
              isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: context.themeData.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.5, // Thicker border when focused
            ),
          ),
        ),
      ),
    );
  }
}
