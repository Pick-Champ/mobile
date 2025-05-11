import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/router/app_router.gr.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/feature/quiz/model/request/quiz_state.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class BracketKingAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const BracketKingAppBar({required this.quizVm, super.key});
  final QuizState quizVm;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMatch = quizVm.matches?[quizVm.currentRoundIndex ?? 0];
    return AppBar(
      backgroundColor: Colors.transparent,
      title: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: currentMatch?.roundLabel ?? '',
          style: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            backgroundColor: Colors.white10,
            color: Colors.white,
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () {
          QuestionAlert().show(
            context,
            bodyText: LocaleKeys.areYouSureExitQuiz.tr(),
            buttonText: LocaleKeys.yes.tr(),
            onTap:
                () => context.router.pushAndPopUntil(
                  const MainRoute(),
                  predicate: (_) => false,
                ),
          );
        },
        icon: Icon(
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 10);
}
