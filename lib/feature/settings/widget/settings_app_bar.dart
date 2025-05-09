import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';

class SettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SettingsAppBar({required this.onTap, super.key});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.themeData.scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: onTap,
        icon: Icon(
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          color: context.themeData.indicatorColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 10);
}
