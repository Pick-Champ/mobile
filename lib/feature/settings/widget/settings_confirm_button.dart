import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class SettingsConfirmButton extends ConsumerWidget {
  const SettingsConfirmButton({
    required this.text,
    required this.onTap,
    super.key,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
            maximumSize: const Size(250, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 15),
            side: BorderSide.none,
          ),
          child: Text(
            text,
            style: context.textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
