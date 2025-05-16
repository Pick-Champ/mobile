import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class CreateQuizAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CreateQuizAppBar({required this.pageCnt, super.key});
  final PageController pageCnt;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1F1F2E),
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            onPressed:
                () => QuestionAlert().show(
                  context,
                  bodyText: LocaleKeys.areYouSureExitQuiz.tr(),
                  buttonText: LocaleKeys.yes.tr(),
                  onTap:
                      () => context.router.pushAndPopUntil(
                        const MainRoute(),
                        predicate: (_) => false,
                      ),
                ),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.amberAccent,
            ),
          ),
          100.horizontalSpace,
          Text(
            pageCnt.page == 1
                ? LocaleKeys.quizDetails.tr()
                : LocaleKeys.selections.tr(),
            style: context.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.screen_search_desktop_outlined,
            color: Colors.amberAccent,
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
