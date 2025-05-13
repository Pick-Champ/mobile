import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_champ/core/const/extensions/context_extension.dart';
import 'package:pick_champ/core/widget/question_alert.dart';
import 'package:pick_champ/feature/comment/widget/comments_widget.dart';
import 'package:pick_champ/feature/reaction/widget/reaction_widget.dart';
import 'package:pick_champ/feature/settings/controller/block_controller.dart';
import 'package:pick_champ/feature/settings/report/report_dialog.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class QuizDetailDrawer extends ConsumerWidget {
  const QuizDetailDrawer({
    required this.userId,
    required this.quizId,
    super.key,
  });
  final String quizId;
  final String userId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: context.screenWidth * 0.85,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              35.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => context.router.pop(),
                    icon: Icon(
                      Icons.close,
                      color: context.themeData.indicatorColor,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                            () => QuestionAlert().show(
                              context,
                              bodyText:
                                  LocaleKeys
                                      .areYouSureYouWantToBlockThisUser
                                      .tr(),
                              buttonText: LocaleKeys.block.tr(),
                              onTap:
                                  () => ref
                                      .read(blockProvider.notifier)
                                      .block(context, ref, userId),
                            ),
                        icon: const Icon(Icons.block, color: Colors.red),
                      ),
                      IconButton(
                        onPressed:
                            () => ReportDialog().show(
                              context,
                              ref,
                              otherId: quizId,
                            ),
                        icon: const Icon(
                          Icons.report_problem_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              35.verticalSpace,
              ReactionWidget(quizId: quizId),
              CommentsWidget(quizId: quizId),
            ],
          ),
        ),
      ),
    );
  }
}
