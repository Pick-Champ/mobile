import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(thickness: 0.4, color: Colors.grey, endIndent: 8),
        ),
        Text(
          text,
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Expanded(
          child: Divider(thickness: 0.4, color: Colors.grey, indent: 8),
        ),
      ],
    );
  }
}
