import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CreateQuizAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateQuizAppBar({required this.pageCnt, super.key});
  final PageController pageCnt;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.themeData.scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            onPressed: () => context.router.pop(),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: context.themeData.indicatorColor,
            ),
          ),
          100.horizontalSpace,
          Text(
            pageCnt.page == 1
                ? LocaleKeys.quizDetails.tr()
                : LocaleKeys.selections.tr(),
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.screen_search_desktop_outlined,
            color: Colors.blue,
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],

      elevation: 3,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 10);
}
