import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/feature/profile/widget/leader_board_info_dialog.dart';
import 'package:pick_champ/generated/assets.dart';

class LeaderBoardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LeaderBoardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF292E55),
      leading: IconButton(
        onPressed: () => context.router.pop(),
        icon: Icon(
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          color: Colors.amberAccent,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            LeaderBoardInfoDialog().show(context);
          },
          icon: Image.asset(Assets.imageQuestion, height: 30),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
