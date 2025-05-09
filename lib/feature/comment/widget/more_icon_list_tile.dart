import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class MoreIconListTile extends StatelessWidget {
  const MoreIconListTile({
    required this.iconData,
    required this.text,
    required this.onTap,
    super.key,
  });
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(iconData, color: Colors.red, size: 24),
      title: Text(text, style: context.textTheme.labelMedium),
      onTap: onTap,
    );
  }
}
